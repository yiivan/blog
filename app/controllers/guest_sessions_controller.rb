class GuestSessionsController < ApplicationController
  rescue_from ActionController::RedirectBackError, with: :redirect_to_default
  before_action :redirect_if_signed_in, only: [:create]

  def create
    user = User.find_by_email "guest@blog.com"
    sign_in(user)
    redirect_to :back, notice: "Signed in as a guest!"
  end

  private

  def redirect_to_default
    redirect_to root_path
  end

  def redirect_if_signed_in
    redirect_to root_path, notice: "Already signed in as #{current_user.first_name}!" if user_signed_in?
  end
end
