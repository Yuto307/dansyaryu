class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit destroy]
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    redirect_back fallback_location: root_path
  end

  def edit; end

  def update
    @comment = current_user.comments.find(params[:id])
    if @comment.update(comment_update_params)
      render json: { comment: @comment }, status: :ok
    else
      render json: { comment: @comment, errors:
      { messages: @comment.errors.full_messages } }, 
      status: :bad_request
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id]) # current_userのコメント
    @comment.destroy!
    redirect_back fallback_location: root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :status).merge(post_id: params[:post_id])
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_update_params
    params.require(:comment).permit(:content)
  end
end
