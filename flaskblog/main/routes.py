from flask import render_template, request, Blueprint
from flaskblog.models import Post, PostLike
from sqlalchemy import func

main = Blueprint('main', __name__)


@main.route("/")
@main.route("/home")
def home():
    page = request.args.get('page', 1, type=int)
    search_post = request.args.get('search_post')
    if search_post:
        posts = Post.query.filter(Post.title.contains(search_post) | Post.content.contains(search_post)).paginate(page=page, per_page=5)
    else:
        posts = Post.query.outerjoin(PostLike).group_by(Post.id).order_by(func.count().desc(), Post.date_posted.desc()).paginate(page=page, per_page=5)
    return render_template('home.html', posts=posts)


@main.route("/about")
def about():
    return render_template('about.html', title='About')
