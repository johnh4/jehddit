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
  end

  def index
  	@posts = Post.all.paginate(page: params[:page])
  end


  private

  	def post_params
  		params.require(:post).permit(:content, :link)
  	end

end
