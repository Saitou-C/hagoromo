class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @posts = Post.find_by(user_id:params[:id])
    @posts.destroy
    redirect_to request.referer
  end

end
