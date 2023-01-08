class BestAnswersController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    current_user.best_answer(@comment)
    # redirect_back fallback_location: root_path, success: t('defaults.message.best_answer', item: Favorite.model_name.human)
  end

  def destroy
    @comment = current_user.best_answers.find(params[:id]).comment
    current_user.normal_answer(@comment)
    # redirect_back fallback_location: root_path, success: t('defaults.message.normal_answer', item: Favorite.model_name.human)
  end
end
