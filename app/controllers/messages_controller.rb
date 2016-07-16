class MessagesController < ApplicationController
	def new
		@user = current_user
		@users = current_user.friends
		@message = Message.new
	end
	def create
		@message = current_user.sent_messages.build(message_params)
		if @message.save
			flash[:notice] = "create message success"
			redirect_to root_path
		else
			flash[:error] = "Can not create message"
			redirect_to new_user_message_path(current_user)
		end
	end

	def show
		@message = Message.find(params[:id])
		if !@message.read? && current_user == @message.recipient
			@message.mark_as_read!
			redirect_to show_path
		end
	end

	private
	def message_params
		params.require(:message).permit(:recipient_id, :title)
	end
end
