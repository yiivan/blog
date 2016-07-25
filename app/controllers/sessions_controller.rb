class SessionsController < ApplicationController
  rescue_from ActionController::RedirectBackError, with: :redirect_to_default
  before_action :redirect_if_signed_in, only: [:new, :create]
  after_filter :save_my_previous_url, only: [:new]

  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect_to session[:my_previous_url], notice: "Signed in!"
      session[:my_previous_url] = ""
    else
      flash.now[:alert] = "Wrong credentials!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back, notice: "Signed out!"
  end

  private

  def redirect_to_default
    redirect_to root_path, notice: "Signed out!"
  end

  def redirect_if_signed_in
    if user_signed_in?
      redirect_to session[:my_previous_url], notice: "Already signed in as #{current_user.first_name}!"
      session[:my_previous_url] = ""
    end
  end

  def save_my_previous_url
    session[:my_previous_url] = URI(request.referer || "").path
  end
end
