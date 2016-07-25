class GuestSessionsController < ApplicationController
  rescue_from ActionController::RedirectBackError, with: :redirect_to_default
  before_action :redirect_if_signed_in, only: [:create]

  def create
    user = User.find_by_email "guest@blog.com"
    sign_in(user)
    if session[:my_previous_url] && session[:my_previous_url] != ""
      redirect_to session[:my_previous_url], notice: "Signed in as a guest!"
      session[:my_previous_url] = ""
    else
      redirect_to :back, notice: "Signed in as a guest!"
    end
  end

  private

  def redirect_to_default
    redirect_to root_path, notice: "Signed in as a guest!"
  end

  def redirect_if_signed_in
    if user_signed_in?
      if session[:my_previous_url] && session[:my_previous_url] != ""
        redirect_to session[:my_previous_url], notice: "Already signed in as #{current_user.first_name}!"
        session[:my_previous_url] = ""
      else
        redirect_to :back, notice: "Already signed in as #{current_user.first_name}!"
      end
    end
  end
end
