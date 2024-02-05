class User::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] #indexとshow以外はログインしていないと開けない
  before_action :is_matching_login_user, only: [:edit, :update, :destroy, :favorites]

  def index
    @users = User.page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(12)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def confirm_withdraw
  end

  def favorites #いいね一覧
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id) #Favoriteテーブルから＠userのuser_idを取→pluckでpost_idを取ってくる
    @favorite_posts = Post.find(favorites)
    @favorite_posts = Kaminari.paginate_array(@favorite_posts).page(params[:page]).per(12) #findメソッドを使って起きるエラー回避
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find_by(:id => params[:id])
  end

  def is_matching_login_user #ログインユーザーかどうか確認
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
end
