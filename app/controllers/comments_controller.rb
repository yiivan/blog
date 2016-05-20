class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_and_authorize_comment, only: [:destroy, :edit, :update]

  def create
    @comment          = Comment.new comment_params
    @comment.post     = @post
    @comment.user     = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post), notice: "Thanks for your comment." }
        format.js { render :create_success }
      else
        flash.now[:alert] = "Comment not saved!"
        format.html { render "/posts/show" }
        format.js { render :create_failure }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Comment deleted!" }
      format.js { render }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @comment.update comment_params
        format.js { render :update_success }
      else
        format.js { render :update_failure }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)  
  end

  def find_post
    @post = Post.find params[:post_id]
  end

  def find_and_authorize_comment
    @comment = @post.comments.find params[:id]
    redirect_to root_path unless can? :crud, @comment
  end

end
