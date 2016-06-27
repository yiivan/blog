class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_post, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user  = current_user
    if @post.save
      redirect_to post_path(@post), notice: "New blog post created!"
    else
      flash.now[:alert] = "Blog post not created!"
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def index
    if params[:search]
      @posts = Post.search(params[:search]).order(:id).page(params[:page]).per(10)
    else
      @posts = Post.all.order(:id).page(params[:page]).per(10)
    end

  end

  def edit
  end

  def update
    if @post.update post_params
      redirect_to post_path(@post), notice: "Blog post updated!"
    else
      flash.now[:alert] = "Blog post not updated!"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Blog post deleted!"
  end

  private

  def authorize_post
    redirect_to root_path unless can? :crud, @post
  end

  def find_post
    @post = Post.find params[:id]
  end

  def post_params
    params.require(:post).permit(:title, :image, :body, :category_id, tag_ids: [])
  end

end
