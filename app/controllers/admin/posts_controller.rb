class Admin::PostsController < Admin::BaseController
    before_action :set_post, only: %i[edit update destroy]
  
    def index
      @q = Post.ransack(params[:q])
      @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    end
  
    def bookmarks
      @q = current_user.bookmark_posts.ransack(params[:q])
      @bookmark_posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    end
  
    def search
      @results = @q.result
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
  
    def edit; end
  
    def update
      if @post.update(post_params)
        redirect_to admin_post_path, success: t('defaults.message.updated', item: Post.model_name.human)
      else
        flash.now[:danger] = t('defaults.message.not_updated', item: Post.model_name.human)
        render :edit
      end
    end
  
    def destroy
      @post.destroy!
      redirect_to admin_posts_path, success: t('defaults.message.deleted', item: Post.model_name.human)
    end
  
    private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
  
    # Only allow a trusted parameter "white list" through.
    def post_params
        params.require(:post).permit(:title, :body, :img, :img_cache, :deadline).merge(user_id: current_user.id)
    end
  end
  