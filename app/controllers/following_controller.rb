class FollowingController < ApplicationController
  before_action :load_user

  def index
    @title = t ".title"
    @users = @user.following.page(params[:page]).per Settings.follow
    render "users/show_follow"
  end
end
