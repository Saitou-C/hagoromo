class Admin::PostCommentsController < ApplicationController

  def destroy
    post_comment = PostComment.find_by(user_id:params[:id])
    post_comment.destroy
    redirect_to request.referer
  end
end
