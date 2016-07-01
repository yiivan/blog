class HomeController < ApplicationController

  def index
    @posts = Post.order(:id).last(3)
  end

  def about
  end

end
