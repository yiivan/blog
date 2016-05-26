module PostsHelper
  def user_favorite
    @user_favorite ||= @post.favorite_for(current_user)
  end
end
