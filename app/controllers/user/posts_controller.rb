class User::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:tagname].split(/[[:blank:]]+/)
    #params[:post][:tagname]からスペースで分割してtag_listに代入
    #連続した空白にも対応するので(/[[:blank:]]+/)の最後の"+"が重要

    if @post.save
      @post.save_tags(tag_list)#postモデルにsave_tagsを定義
      redirect_to root_path, notice:'投稿が完了しました'
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def index
    @posts = Post.page(params[:page]).per(12)
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user_id
    @post_comment = PostComment.new #コメント機能
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end
end
