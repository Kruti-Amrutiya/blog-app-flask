from flask import url_for
from flask_mail import Message
from flaskblog import mail, celery, create_app
from flaskblog.models import User


@celery.task(name='send_reset_email')
def send_reset_email(user_email):
    app  = create_app()
    app.app_context().push()
    print("email")
    user = User.query.filter_by(email=user_email).first()
    print(user_email)
    print(user)
    token = user.get_reset_token()
    msg = Message('Password Reset Request',
                sender='krutiamrutiya1998@gmail.com',
                recipients=[user.email])
    msg.body = f'''To reset your password, visit the following link:
{url_for('users.reset_token', token=token, _external=True)}

If you did not make this request then simply ignore this email and no changes will be made.
'''
    mail.send(msg)


@celery.task(name="reverse")
def reverse(string):
    print("new")
    return string[::-1]
