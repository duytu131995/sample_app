class FollowersController < ApplicationController
  before_action :load_user

  def index
    @title = t ".title"
    @users = @user.followers.page(params[:page]).per Settings.follow
    render "users/show_follow"
  end
end
