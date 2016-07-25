class GuestSessionsController < ApplicationController
  before_action :redirect_if_signed_in, only: [:create]

  def create
    user = User.find_by_email "guest@blog.com"
    sign_in(user)
    redirect_to session[:my_previous_url], notice: "Signed in as a guest!"
    session[:my_previous_url] = ""
  end

  private

  def redirect_if_signed_in
    if user_signed_in?
      redirect_to session[:my_previous_url], notice: "Already signed in as #{current_user.first_name}!"
      session[:my_previous_url] = ""
    end
  end
end
