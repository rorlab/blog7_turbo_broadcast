class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to posts_path }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
