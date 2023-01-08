class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.favorite(@post)
    # redirect_back fallback_location: root_path, success: t('defaults.message.favoriteed', item: Favorite.model_name.human)
  end

  def destroy
    @post = current_user.favorites.find(params[:id]).post
    current_user.unfavorite(@post)
    # redirect_back fallback_location: root_path, success: t('defaults.message.unfavorited', item: Favorite.model_name.human)
  end
end
