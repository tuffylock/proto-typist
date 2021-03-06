class SessionsController < ApplicationController
  before_action :require_no_account!, except: :destroy

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.caseless_find('username', params[:user][:username])

    if user && user.authenticate(params[:user][:password])
      log_in!(user)
      redirect_to root_url
    else
      flash.now[:alert] = ["Invalid username or password"]
      @user = User.new(username: params[:user][:username])
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to root_url
  end
end
