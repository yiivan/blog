class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :authorize_comment, only: :destroy

  def create
    comment_params    = params.require(:comment).permit(:body)
    @comment          = Comment.new comment_params
    @comment.post     = @post
    @comment.user     = current_user
    if @comment.save
      redirect_to post_path(@post), notice: "Thanks for your comment."
    else
      flash.now[:alert] = "Comment not saved!"
      render "/posts/show"
    end
  end

  def destroy
    @comment = @post.comments.find params[:id]
    @comment.destroy
    redirect_to post_path(@post), notice: "Comment deleted!"
  end

  private

  def find_post
    @post = Post.find params[:post_id]
  end

  def authorize_comment
    redirect_to root_path unless can? :destroy, @comment
  end

end
