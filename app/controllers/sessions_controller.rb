class SessionsController < ApplicationController
  before_action :redirect_if_signed_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path, notice: "Signed In!"
    else
      flash.now[:alert] = "Wrong Credentials!"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out!"
  end

  private

  def redirect_if_signed_in
    redirect_to root_path, notice: "Already signed in as #{current_user.first_name}!" if user_signed_in?
  end
end
