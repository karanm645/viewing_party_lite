class UsersController < ApplicationController 
  def show 
    @user = User.find(params[:id])
    @parties = ViewingParty.where(host_id: @user.id)
  end

  #user = User.find_by
  #user.authenticate('') #string is password (params[:password])
  def new 
  end

  def create
    user = User.create(user_params)
    session[:user_id] = user.id
    if user.save
      flash[:success] = "User Created!"
      redirect_to user_path(user.id)
    elsif params[:password].empty? || params[:password_confirmation].empty?
      flash[:error] = "Fill out the password!"
      redirect_to register_path
    else 
      redirect_to register_path 
    end 
  end

  def login_form 
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password]) && params[:password] == params[:password_confirmation]
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else 
      render :login_form 
      flash[:error] = "Invalid Credentials!" # make sure you fix this because it shows up when you're logged in
    end 
  end 

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)    
  end
end