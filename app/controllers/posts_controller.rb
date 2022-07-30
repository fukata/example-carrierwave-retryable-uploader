class PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.order(id: :desc).limit(100)
  end

  def create
    Post.transaction do
      Post.create!(create_params)
    end
    redirect_to posts_path, notice: "投稿に成功しました。"
  rescue ActiveRecord::RecordInvalid => e
    logger.error e
    @post = e.record
    @posts = Post.order(id: :desc).limit(100)
    render :index
  rescue => e
    logger.error e
    logger.error e.backtrace.join("\n")
    raise e
  end

  def destroy
    redirect_to posts_path, notice: "削除に成功しました。"
  end

  private
  def create_params
    params.require(:post).permit(:title, :image)
  end
end
