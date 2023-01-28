class BestAnswersController < ApplicationController
  before_action :authenticate_user

  def create
    @best_answer = current_user.best_answers.build(best_answer_params)
    @comment = @best_answer.comment
    if @best_answer.valid?
      @best_answer.save
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @best_answer = BestAnswer.find(params[:id])
    @comment = @best_answer.comment
    if @best_answer.destroy
      redirect_back fallback_location: root_path
    end
  end

  private
  def best_answer_params
    params.permit(:comment_id)
  end
end
