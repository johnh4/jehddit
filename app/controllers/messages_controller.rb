class MessagesController < ApplicationController
  before_action :signed_in_user
  def new
  	#@message = Message.new
  	@user = User.find(params[:user_id])
  end

  def create
  	@message = Message.new(message_params)
  	@user = User.find(params[:message][:receiver_id])
  	@message.sender_id = current_user.id
  	@message.receiver_id = @user.id
  	if @message.save
  		flash[:success] = "Message Sent."
  		redirect_to user_messages_path(current_user)
  	else
  		flash.now[:error] = "Message could not be sent."
  		render 'new'
  	end
  end

  def show
  	@message = Message.find(params[:id])
  end

  def index
  	@sent = current_user.sent_messages
  	@received = current_user.received_messages
  end

  private
  	def message_params
  		params.require(:message).permit(:content)
  	end
end
