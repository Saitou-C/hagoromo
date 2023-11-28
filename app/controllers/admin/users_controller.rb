class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def post_index
    @posts = Post.where(user_id:params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end

end
