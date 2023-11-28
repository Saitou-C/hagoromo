class Admin::PostsController < ApplicationController

  def show

  end

  def destroy
    post = Post.find_by(user_id:params[:id])
    post.destroy
    redirect_to posts_path
  end

end
