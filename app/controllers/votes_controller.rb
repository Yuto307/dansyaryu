class VotesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @vote = current_user.votes.create(vote_params)
  end

  def destroy
    @post = current_user.votes.find(params[:id]).post
    current_user.unvote(@post)
    redirect_back fallback_location: root_path
  end

  private

  def vote_params
    params.permit(:status).merge(post_id: params[:post_id])
  end
end
