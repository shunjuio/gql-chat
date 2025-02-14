class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    p params[:name]
    user = User.find_or_create_by!(name: params[:name])
    log_in(user)
    redirect_to root_path
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
