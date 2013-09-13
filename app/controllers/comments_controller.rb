class CommentsController < ApplicationController
  def new
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.build
  end

  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.build(comment_params)
	@comment.vote_count = 0
	@comment.user_id = current_user.id
	if params[:comment_id]
		@op = Comment.find(params[:comment_id])
		@comment.op_id = @op.id
	end
  	if @comment.save
  		flash[:success] = "Comment posted!"
  		redirect_to @post
  	else
  		flash.now[:error] = "Comment failed to post."
  		render 'new'
  	end
  end

  def show
  	@comment = Comment.find(params[:id])
  end

  def reply
  	@post = Post.find(params[:post_id])
  	@op = Comment.find(params[:comment_id])
  end

  def upvote
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @comment.update(vote_count: @comment.vote_count + 1)
    
    @comments = @post.comments.where(op_id: nil)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def downvote
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:comment_id])
    @comment.update(vote_count: @comment.vote_count - 1)

    @comments = @post.comments.where(op_id: nil)
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
  	@post = Post.find(params[:post_id])
  	@comment = Comment.find(params[:id])
  	@comment.destroy
  	flash[:success] = "Comment deleted."
  	redirect_to @post
  end


  private

  	def comment_params
  		params.require(:comment).permit(:content)
  	end

end
