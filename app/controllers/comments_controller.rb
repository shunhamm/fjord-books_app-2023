# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.all
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save!
    redirect_to [@commentable, @comment]
  end

  private

  # https://nekorails.hatenablog.com/entry/2019/06/13/031003　より
  def set_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
