from flask import (render_template, url_for, flash,
                   redirect, request, abort, Blueprint, jsonify, json)
from flask_login import current_user, login_required
from flaskblog import db
from flaskblog.models import Post, Comment
from flaskblog.posts.forms import PostForm, AddCommentForm
from datetime import datetime

posts = Blueprint('posts', __name__)


@posts.route("/post/new", methods=['GET', 'POST'])
@login_required
def new_post():
    form = PostForm()
    if form.validate_on_submit():
        post = Post(title=form.title.data, content=form.content.data, author=current_user)
        db.session.add(post)
        db.session.commit()
        flash('Your post has been created!', 'success')
        return redirect(url_for('main.home'))
    return render_template('create_post.html', title='New Post', form=form, legend='New Post')


@posts.route("/post/<int:post_id>", methods=['GET', 'POST'])
@login_required
def post(post_id):
    post = Post.query.get_or_404(post_id)
    form = AddCommentForm()
    post.comments.count()
    if form.validate_on_submit():
        comment = Comment(body=form.body.data, article=post, user=current_user)
        db.session.add(comment)
        db.session.commit()
        print(post.comments)
        flash("Your comment has been added to the post", "success")
        return redirect(url_for("posts.post", post_id=post.id))
    num = post_id
    comments = db.session.query(Comment).filter(Comment.post_id == num).all()
    return render_template('post.html', title=post.title, post=post, form=form, comments=comments)


@posts.route("/post/<int:post_id>/update", methods=['GET', 'POST'])
@login_required
def update_post(post_id):
    post = Post.query.get_or_404(post_id)
    if post.author != current_user:
        abort(403)
    form = PostForm()
    if form.validate_on_submit():
        post.title = form.title.data
        post.content = form.content.data
        post.updated_date = datetime.utcnow()
        db.session.commit()
        flash('Your post has been updated!', 'success')
        return redirect(url_for('posts.post', post_id=post.id))
    elif request.method == 'GET':
        form.title.data = post.title
        form.content.data = post.content
    return render_template('create_post.html', title='Update Post', form=form, legend='Update Post')


@posts.route("/post/<int:post_id>/delete", methods=['POST'])
@login_required
def delete_post(post_id):
    post = Post.query.get_or_404(post_id)
    if post.author != current_user:
        abort(403)
    db.session.delete(post)
    db.session.commit()
    flash('Your post has been deleted!', 'success')
    return redirect(url_for('main.home'))


@posts.route('/like_unlike')
# @login_required
def like_action():

    print('hello')
    post_id = request.args.get('post_id')
    post = Post.query.get(post_id)
    print(post)
    action = request.args.get('action')

    if action == 'like':
        print('inside like ')
        current_user.like_post(post)
        db.session.commit()
        print(post.likes.count())
        data = {'count': post.likes.count(), 'action': 'like'}
        return jsonify(data)

    if action == 'unlike':
        print("inside unlike")
        current_user.unlike_post(post)
        db.session.commit()
        print(post.likes.count())
        data = {'count': post.likes.count(), 'action': 'unlike'}
        return jsonify(data)

    return redirect(request.referrer)


@posts.route("/post/<int:comment_id>/delete", methods=['GET', 'POST'])
@login_required
def delete_comment(comment_id):
    comments = Comment.query.get_or_404(comment_id)
    db.session.delete(comments)
    db.session.commit()
    flash('Your comment has been deleted!', 'success')
    return redirect(request.referrer)
