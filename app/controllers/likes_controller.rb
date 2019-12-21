class LikesController < ApplicationController
  def like
    @like = Like.new
    @like.post_id = params[:post_id]
    @like.user_id = current_user.id
    @like.save
    redirect_to posts_path
  end

  def unlike
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_to posts_path
  end
end
