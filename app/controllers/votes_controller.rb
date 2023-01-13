class VotesController < ApplicationController
  before_action :set_vote, only: %i[edit update destroy]
  def create
    @vote = current_user.votes.create(vote_params)
  end

  def edit; end

  def update
    if @vote.update(vote_params)
      redirect_to @vote, success: t('defaults.message.updated', item: Vote.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Vote.model_name.human)
      render :edit
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
    params.require(:vote).permit(:status)
  end
end
