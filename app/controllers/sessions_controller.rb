class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      flash[:success] = t ".success"
      log_in user
      redirect_to user
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
