class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email,
                                               :password, :password_confirmation)
    @user = User.new user_params
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: "Account created!"
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    user_params = params.require(:user).permit(:first_name, :last_name, :email)
    if @user.update user_params
      redirect_to root_path, notice: "User info updated!"
    else
      redirect_to edit_users_path, alert: "User info not updated!"
    end
  end

  def edit_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user && @user.authenticate(params.require(:user).permit(:current_password)[:current_password])

      if params.require(:user).permit(:password)[:password] == params.require(:user).permit(:current_password)[:current_password]
        redirect_to edit_password_users_path, alert: "New password has to be different from the current password!"
      elsif @user.update params.require(:user).permit(:password, :password_confirmation)
        redirect_to root_path, notice: "Password updated!"
      else
        redirect_to edit_password_users_path, alert: "Password not updated!"
      end

    else
      redirect_to edit_password_users_path, alert: "Wrong password!"
    end
  end

end
