class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [ :edit, :update, :destroy]

  def index
    @comment = Comment.new
  end


  def new
    @post = Post.new # フォーム用の空のインスタンスを生成する。
  end

  def create# ストロングパラメータを引数に
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: "投稿を登録しました。"
    else
      render :new
    end
  end

  def show
    @posts = Post.find_newest_post(params[:page]).with_user_and_comment
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "投稿を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params # ストロングパラメータを定義する
    params.require(:post).permit(:caption, :new_image, :user_id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end