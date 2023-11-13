# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to [@commentable]
  end

  def destroy
    @comment = Comment.find(params[:id])
    return redirect_to [@commentable], notice: t('errors.messages.unmatched_user', name: current_user.name) unless @comment.user.id == current_user.id

    @comment.destroy

    redirect_to [@commentable], notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
