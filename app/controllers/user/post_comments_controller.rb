class User::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:destroy]

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to request.referer
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end


  def is_matching_login_user #ログインユーザーかどうか確認
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to root_path
    end
  end
end
