class HomeController < ApplicationController

  def index
    @post01 = Post.order(:id).last
    @post02 = Post.order(:id).last(2).first
    @post03 = Post.order(:id).last(3).first
  end

  def about
  end

end
