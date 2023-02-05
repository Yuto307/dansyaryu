class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update judgment destroy]
  before_action :ensure_user, only: %i[edit update judgment destroy]

  def index
    @categories = Category.all
    @q = Post.where.not(status: :draft).ransack(params[:q])
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @posts = @category.posts.where.not(status: :draft).order(created_at: :desc).page(params[:page])
    else
      @posts = @q.result(distinct: true).includes(:user, :comments).order(created_at: :desc).page(params[:page])
    end
  end

  def favorites
    @categories = Category.all
    @q = current_user.favorite_posts.where.not(status: :draft).ransack(params[:q])
    @favorite_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def drafts
    @categories = Category.all
    @q = current_user.posts.where(status: :draft).ransack(params[:q])
    @draft_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end
  
  def search
    @results = @q.result
  end

  def judgment; end

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
    @vote = Vote.find_by(post: @post, user: current_user) || Vote.new
  end

  def edit; end

  def update
    authorize(@post)

    @post.assign_attributes(post_params)
    @post.adjust_status
    if @post.update(post_params)
      redirect_to @post, success: t('defaults.message.updated', item: Post.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit
    end
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
    params.require(:post).permit(:title, :body, :img, :img_cache, { category_ids: [] }, :status, :deadline).merge(user_id: current_user.id)
  end

  def ensure_user
    @post = Post.find_by(id: params[:id])
    return unless @post.user_id != @current_user.id

    redirect_to posts_path
  end

end
