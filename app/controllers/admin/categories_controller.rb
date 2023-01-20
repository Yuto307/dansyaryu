class Admin::CategoriesController  < Admin::BaseController
  before_action :set_category, only: %i[edit update destroy]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end
  
  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result(distinct: true).order(created_at: :desc).page(params[:page])
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def edit; end
  
  def update
    if @category.update(category_params)
      redirect_to admin_category_path, success: t('defaults.message.updated', item: Category.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Category.model_name.human)
      render :edit
    end
  end
  
  def destroy
    @category.destroy!
    redirect_to admin_categories_path, success: t('defaults.message.deleted', item: Category.model_name.human)
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def set_category
    @category = Category.find(params[:id])
  end
end
