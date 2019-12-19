class CommentsController < ApplicationController
  def create
    # binding.pry
    @comment = Comment.new(comment_params)
          @comment.attributes = {
      user_id: current_user.id
    }
    if @comment.save
      redirect_to posts_path, notice: "コメントを保存しました。"
    else
      @posts = Post.order(created_at: :desc)
      render template: "posts/index"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to posts_path, notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
end