"""empty message

Revision ID: 5241e58c6824
Revises: afca5b3ea9b8
Create Date: 2021-04-29 11:24:39.913379

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '5241e58c6824'
down_revision = 'afca5b3ea9b8'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('comment', sa.Column('created_date', sa.DateTime(), nullable=True))
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('comment', 'created_date')
    # ### end Alembic commands ###
