class User::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] #indexとshow以外はログインしていないと開けない
  before_action :is_matching_login_user, only: [:destroy]

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
    redirect_to root_path
  end

  def index
    @posts = Post.page(params[:page]).per(12)
    @posts = Post.page(params[:page]).per(12).order(created_at: :desc)
    #order:ソートの順序　created_at:データの作成日　desc:ソートの降順
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

    def is_matching_login_user #ログインユーザーかどうか確認
      @post = Post.find(params[:id])
      user = @post.user
      unless user.id == current_user.id
        redirect_to root_path
      end
    end
end
