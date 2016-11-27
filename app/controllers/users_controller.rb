class UsersController < ApplicationController
  after_action :verify_authorized, only: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :notice => 'User Deleted'
  end
end