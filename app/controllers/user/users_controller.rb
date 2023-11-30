class User::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
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
    
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def set_user
    @user = User.find_by(:id => params[:id])
  end
end
