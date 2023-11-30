class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def post_index
    @user = User.find(params[:id])
    @posts = Post.where(user_id:params[:id])
  end

  def post_comment_index
    @user = User.find(params[:id])
    @post_comments = PostComment.where(user_id:params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
  end

end
