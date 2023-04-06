class ClosesController < ApplicationController
  before_action :set_post

  def update
    @post.deadline = Time.current unless @post.deadline?
    @post.status = @post.closed? ? :closing : :published

    if @post.valid?
      @post.save

      flash[:notice] = @post.message_on_closing

      redirect_to edit_post_path(@post)
    else
      flash.now[:alert] = 'エラーがあります。確認してください。'

      @post.status = @post.status_was if @post.status_changed?
      render 'posts/edit'
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
