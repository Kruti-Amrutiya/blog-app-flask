"""empty message

Revision ID: 124c9082230d
Revises: ed32d31fb9a9
Create Date: 2021-05-11 16:20:52.387628

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '124c9082230d'
down_revision = 'ed32d31fb9a9'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('followers',
    sa.Column('follower_id', sa.Integer(), nullable=True),
    sa.Column('followed_id', sa.Integer(), nullable=True),
    sa.ForeignKeyConstraint(['followed_id'], ['user.id'], ),
    sa.ForeignKeyConstraint(['follower_id'], ['user.id'], )
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('followers')
    # ### end Alembic commands ###
