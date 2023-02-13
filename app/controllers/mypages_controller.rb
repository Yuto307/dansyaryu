class MypagesController < ApplicationController
  before_action :set_user,only: %i[edit update]

  def show
    @best_answers = BestAnswer.all
  end

  def edit
  end
      
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
    @post = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def published
    @q = current_user.posts.where(status: :published).ransack(params[:q])
    @published = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def draft
    @q = current_user.posts.where(status: :draft).ransack(params[:q])
    @draft = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def closing
    @q = current_user.posts.where(status: :closing).ransack(params[:q])
    @closing = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def trash
    @q = current_user.posts.where(status: :trash).ransack(params[:q])
    @trash = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def untrash
    @q = current_user.posts.where(status: :untrash).ransack(params[:q])
    @untrash = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end
      
  private
  def set_user
    @user = User.find(current_user.id)
  end
      
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
