class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user.try(:authenticate, params[:session][:password])
      flash[:success] = t ".success"
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def destroy
    flash[:success] = t ".success"
    log_out
    redirect_to root_url
  end
end
