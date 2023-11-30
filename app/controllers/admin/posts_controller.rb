class Admin::PostsController < ApplicationController

  def destroy
    post = Post.find_by(user_id:params[:id])
    post.destroy
    redirect_to request.referer
  end

end
