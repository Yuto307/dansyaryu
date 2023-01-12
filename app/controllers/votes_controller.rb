class VotesController < ApplicationController
  before_action :set_vote, only: %i[edit destroy]
  def create
    @vote = current_user.votes.create(vote_params)
  end

  def edit; end

  def update
    @vote = current_user.votes.find(params[:id])
    if @vote.update(vote_update_params)
      render json: { vote: @vote }, status: :ok
    else
      render json: { vote: @vote, errors:
      { messages: @vote.errors.full_messages } }, 
      status: :bad_request
    end
  end

  def destroy
    @vote = current_user.votes.find(params[:id]) # current_userのコメント
    @vote.destroy!
  end

  private

  def vote_params
    params.require(:vote).permit(:status).merge(post_id: params[:post_id])
  end

  def set_vote
    @vote = Vote.find_by(id: params[:id])
  end

  def vote_update_params
    params.require(:vote).permit(:content)
  end
end
