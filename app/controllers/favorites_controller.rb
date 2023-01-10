class FavoritesController < ApplicationController
  before_action :authenticate_user

  def create
    @favorite = current_user.favorites.build(favorite_params)
    @post = @favorite.post
    if @favorite.valid?
      @favorite.save
      redirect_to post_path(@post)
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @post = @favorite.post
    if @favorite.destroy
      redirect_to post_path(@post)
    end
  end

  private
  def favorite_params
    params.permit(:post_id)
  end
end
