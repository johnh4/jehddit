class PostsController < ApplicationController
  def new
  	@post = current_user.posts.build
  end

  def create
  	@post = current_user.posts.build(post_params)
  	@post.vote_count = 0
  	if @post.save
  		flash[:success] = "Posted!"
  		redirect_to @post
  	else
  		flash.now[:error] = "Unable to post. Try again."
  		render 'new'
  	end
  end

  def show
  	@post = Post.find(params[:id])
  	@user = @post.user
    @comments = @post.comments
  end

  def index
  	@posts = Post.all.paginate(page: params[:page])
  end

  def update
    @post = Post.find(params[:id])
  end

  def upvote
    @post = Post.find(params[:id])
    vote_count = @post.vote_count + 1
    @post.update(vote_count: vote_count)
    redirect_to posts_path
  end

  def downvote
    @post = Post.find(params[:id])
    vote_count = @post.vote_count - 1
    @post.update(vote_count: vote_count)
    redirect_to posts_path
  end

  private

  	def post_params
  		params.require(:post).permit(:content, :link)
  	end

end
