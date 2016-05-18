class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    favorite = Favorite.new
    favorite.user = current_user
    favorite.post = post
    if favorite.save
      redirect_to post, notice: "Favorite saved!"
    else
      redirect_to post, alert: "You'va already make this into your favorite!"
    end
  end

  def index
  end

  def destroy
    favorite = Favorite.find params[:id]
    favorite.destroy
    redirect_to post_path(favorite.post_id), notice: "Favorite deleted!"
  end

  private

  def post
    @post ||= Post.find params[:post_id]
  end

  def favorite
    @favorite ||= Favorite.find params[:id]
  end

end
