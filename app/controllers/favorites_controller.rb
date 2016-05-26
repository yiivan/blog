class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    favorite = Favorite.new
    favorite.user = current_user
    favorite.post = post
    respond_to do |format|
      if favorite.save
        format.html { redirect_to post, notice: "Favorite saved!" }
        format.js   { render }
      else
        format.html { redirect_to post, alert: "You'va already make this into your favorite!" }
        format.js   { render js: "alert('Can\'t favorite, please refresh the page!');" }
      end
    end
  end

  def index
  end

  def destroy
    post
    favorite = Favorite.find params[:id]
    favorite.destroy
    respond_to do |format|
      format.html { redirect_to post_path(favorite.post_id), notice: "Favorite deleted!" }
      format.js { render }
    end
  end

  private

  def post
    @post ||= Post.find params[:post_id]
  end

  def favorite
    @favorite ||= Favorite.find params[:id]
  end

end
