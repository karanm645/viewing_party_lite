class UserController < ApplicationController 
  def show 
    @user = User.find(params[:id])
    @parties = ViewingParty.where(host_id: @user.id)
  end

  #user = User.find_by
  #user.authenticate('') #string is password (params[:password])
  def new 
  end

  def create
    user = User.create!(user_params)
    redirect_to user_path(user.id)
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)    
  end
end