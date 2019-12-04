  class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.attributes = {
      user_id: current_user.id
    }
    if @comment.save
      redirect_to posts_path, notice: "コメントを保存しました。"
    else
      @posts = Post.order(created_at: :desc)
      render posts_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end

  end