class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy, :update, :edit]

  def create
    @comment = @post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to posts_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(:new_comment, partial: "comments/form", locals: { comment: @comment }) }
        format.html { render :new }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    respond_to do |format|
      if @comment.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
        format.html { redirect_to posts_path }
      else
        format.html { redirect_to @post, notice: "Comment could not be deleted." }
      end
    end
  end

  def update
    @comment = @post.comments.find(params[:id])
    
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@comment, partial: "comments/comment", locals: { comment: @comment }) }
        format.html { redirect_to @post, notice: "Comment was successfully updated." }
      else
        format.html { redirect_to @post, notice: "Comment could not be updated." }
      end
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
