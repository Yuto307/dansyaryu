class VotesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    if status == 'trash'
      current_user.trash(@post)
      redirect_back fallback_location: root_path
    elsif status == 'untrash'
      current_user.untrash(@post)
      redirect_back fallback_location: root_path
    end
  end

  def update
    @post = current_user.votes.find(params[:id]).post
    if status == 'trash'
      current_user.update_trash(@post)
      redirect_back fallback_location: root_path
    elsif status == 'untrash'
      current_user.update_untrash(@post)
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @post = current_user.votes.find(params[:id]).post
    current_user.unvote(@post)
    redirect_back fallback_location: root_path
  end

  private

  def vote_params
    params.require(:vote).permit(:status).merge(post_id: params[:post_id])
  end

  def vote_update_params
    params.require(:vote).permit(:status).merge(post_id: params[:post_id])
  end
end
