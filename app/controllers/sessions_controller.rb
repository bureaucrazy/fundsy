class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by_email params[:email]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:notice] = "Logged in!"
    else
      flash[:alert] = "Wrong credentials!"
      # render nothing: true
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    # render nothing: true
    redirect_to root_path, notice: "Signed out successfully!"
  end

end
