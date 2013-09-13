class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		flash[:success] = "You have successfully signed up!"
  		redirect_to @user
  	else
  		flash.now[:error] = "Signed up failed."
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def index
  end


  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    #before_actions
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

end
