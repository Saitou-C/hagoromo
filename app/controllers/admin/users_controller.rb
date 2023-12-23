class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(12)
  end

  def post_index
    @user = User.find(params[:id])
    @posts = Post.where(user_id:params[:id])
    @posts= Kaminari.paginate_array(@posts).page(params[:page]).per(12)
  end

  def post_comment_index
    @user = User.find(params[:id])
    @post_comments = PostComment.where(user_id:params[:id])
    @post_comments= Kaminari.paginate_array(@post_comments).page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザー情報を削除しました"
    redirect_to admin_path
  end

end
