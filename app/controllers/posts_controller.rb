class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :ensure_user, only: %i[edit update destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: t('.success')
    else
      flash.now[:danger] = (t '.fail')
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: t('defaults.message.deleted', item: Post.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = current_user.posts.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def post_params
    params.require(:post).permit(:title, :body, :img, :img_cache, :deadline).merge(user_id: current_user.id)
  end

  def ensure_user
    @post = Post.find_by(id: params[:id])
    return unless @post.user_id != @current_user.id

    redirect_to boards_path
  end

end
