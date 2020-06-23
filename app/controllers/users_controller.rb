class UsersController < ApplicationController
  before_action :load_user, except: %i(new create index)
  before_action :logged_in_user, except: %i(new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.kaminari.per
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".info"
      redirect_to @user
    else
      flash[:danger] = t ".danger"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    redirect_to users_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".notice_id"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def logged_in_user
    return if logged_in

    store_location
    flash[:danger] = t "logged_in_user.danger"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
