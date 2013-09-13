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
  	if @comment.save
  		flash[:success] = "Comment posted!"
  		redirect_to @post
  	else
  		#flash.now[:error] = "Comment failed to post."
  		render 'new'
  	end
  end

  def show
  	@comment = Comment.find(params[:id])
  end


  private

  	def comment_params
  		params.require(:comment).permit(:content, :vote_count)
  	end

end
