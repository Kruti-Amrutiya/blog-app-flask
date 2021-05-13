from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import login_user, current_user, logout_user, login_required
from flaskblog import db, bcrypt
from flaskblog.models import User, Post, followers
from flaskblog.users.forms import (RegistrationForm, LoginForm, UpdateAccountForm,
                                    RequestResetForm, ResetPasswordForm)
from flaskblog.users.utils import save_picture, send_reset_email

users = Blueprint('users', __name__)


@users.route("/register", methods=['GET', 'POST'])
def register():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
    form = RegistrationForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user = User(username=form.username.data, email=form.email.data, password=hashed_password)
        db.session.add(user)
        db.session.commit()
        flash('Your account has been created! You are now able to log in', 'success')
        return redirect(url_for('users.login'))
    return render_template('register.html', title='Register', form=form)


@users.route("/login", methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            login_user(user, remember=form.remember.data)
            next_page = request.args.get('next')
            return redirect(next_page) if next_page else redirect(url_for('main.home'))
        else:
            flash('Login Unsuccessful. Please check email and password', 'danger')
    return render_template('login.html', title='Login', form=form)


@users.route("/logout")
def logout():
    logout_user()
    return redirect(url_for('main.home'))


@users.route("/account", methods=['GET', 'POST'])
@login_required
def account():
    form = UpdateAccountForm()
    if form.validate_on_submit():
        if form.picture.data:
            picture_file = save_picture(form.picture.data)
            current_user.image_file = picture_file
        current_user.username = form.username.data
        current_user.email = form.email.data
        db.session.commit()
        flash('Your account has been updated!', 'success')
        return redirect(url_for('users.account'))
    elif request.method == 'GET':
        form.username.data = current_user.username
        form.email.data = current_user.email
    image_file = url_for('static', filename='profile_pics/' + current_user.image_file)
    return render_template('account.html', title='Account', image_file=image_file, form=form)


@users.route("/user_profile/<int:user_id>", methods=['GET', 'POST'])
@login_required
def user_profile(user_id=None):
    user = User.query.get_or_404(user_id)
    return render_template('user_profile.html', title='User Profile', user=user)


@users.route("/user/<string:username>")
@login_required
def user_posts(username):
    page = request.args.get('page', 1, type=int)
    user = User.query.filter_by(username=username).first_or_404()
    posts = Post.query.filter_by(author=user)\
        .order_by(Post.date_posted.desc())\
        .paginate(page=page, per_page=5)
    return render_template('user_posts.html', posts=posts, user=user)


@users.route("/reset_password", methods=['GET', 'POST'])
def reset_request():
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
    form = RequestResetForm()
    if form.validate_on_submit():
        user = User.query.filter_by(email=form.email.data).first()
        send_reset_email(user)
        flash('An email has been sent with instructions to reset your password.', 'info')
        return redirect(url_for('users.login'))
    return render_template('reset_request.html', title='Reset Password', form=form)


@users.route("/reset_password/<token>", methods=['GET', 'POST'])
def reset_token(token):
    if current_user.is_authenticated:
        return redirect(url_for('main.home'))
    user = User.verify_reset_token(token)
    if user is None:
        flash('That is an invalid or expired token', 'warning')
        return redirect(url_for('users.reset_request'))
    form = ResetPasswordForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data).decode('utf-8')
        user.password = hashed_password
        db.session.commit()
        flash('Your password has been updated! You are now able to log in', 'success')
        return redirect(url_for('users.login'))
    return render_template('reset_token.html', title='Reset Password', form=form)


@users.route('/follow/<username>')
@login_required
def follow(username):
    user = User.query.filter_by(username=username).first()
    print(user)
    if user is None:
        flash('User %s not found.' % username, 'danger')
        return redirect(url_for('main.home'))
    if user == current_user:
        flash('You can\'t follow yourself!', 'danger')
        return redirect(url_for('users.user_profile', user_id=user.id))
    u = current_user.follow(user)
    if u is None:
        flash('Cannot follow ' + username + '.', 'danger')
        return redirect(url_for('users.user_profile', user_id=user.id))
    db.session.add(u)
    db.session.commit()
    flash('You are now following ' + username + '!', 'success')
    return redirect(url_for('users.user_profile', user_id=user.id))


@users.route('/unfollow/<username>')
@login_required
def unfollow(username):
    user = User.query.filter_by(username=username).first()
    print(user)
    if user is None:
        flash('User %s not found.' % username, 'danger')
        return redirect(url_for('main.home'))
    if user == current_user:
        flash('You can\'t unfollow yourself!', 'danger')
        return redirect(url_for('users.user_profile', user_id=user.id))
    u = current_user.unfollow(user)
    if u is None:
        flash('Cannot unfollow ' + username + '.', 'danger')
        return redirect(url_for('users.user_profile', user_id=user.id))
    db.session.add(u)
    db.session.commit()
    flash('You have stopped following ' + username + '.', 'success')
    return redirect(url_for('users.user_profile', user_id=user.id))


@users.route("/userListFollowers/<username>")
@login_required
def listFollowers(username):
    user = User.query.filter_by(username=username).first_or_404()
    user_followers = user.followers.all()
    return render_template('user_profile.html', user_followers=user_followers, user=user, user_id=user.id)


@users.route("/userListFollowing/<username>")
@login_required
def listFollowing(username):
    user = User.query.filter_by(username=username).first_or_404()
    user_following = user.followed.all()
    return render_template('user_profile.html', user_following=user_following, user=user, user_id=user.id)


@users.route("/user_profile/<int:user_id>/delete", methods=['GET', 'POST'])
@login_required
def removeFollower(user_id):
    user = User.query.filter_by(id=user_id).first_or_404()
    print(user)
    follow = db.session.query(User).get(1)
    follow.followers.remove()
    db.session.commit()
    # follow = followers.query.filter(follower_id == user.id, followed_id == current_user.id)
    print(follow)
    # db.session.delete(follow)
    # db.session.commit()
    flash('Your follower has been removed!', 'success')
    return redirect(url_for('users.user_profile'))
