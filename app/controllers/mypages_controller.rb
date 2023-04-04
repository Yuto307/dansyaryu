class MypagesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @best_answers = BestAnswer.all
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to mypage_path, success: t('.success')
    else
      flash.now[:danger] = (t '.fail')
      render :edit
    end
  end

  def post
    @q = current_user.posts.where.not(status: :draft).ransack(params[:q])
    @post = results
  end

  def published
    @q = current_user.posts.where(status: :published).ransack(params[:q])
    @published = results
  end

  def draft
    @q = current_user.posts.where(status: :draft).ransack(params[:q])
    @draft = results
  end

  def closing
    @q = current_user.posts.where(status: :closing).ransack(params[:q])
    @closing = results
  end

  def trash
    @q = current_user.posts.where(status: :trash).ransack(params[:q])
    @trash = results
  end

  def untrash
    @q = current_user.posts.where(status: :untrash).ransack(params[:q])
    @untrash = results
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def results
    @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end
end
