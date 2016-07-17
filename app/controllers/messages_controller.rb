class MessagesController < ApplicationController
	before_action :require_login, only: [:new, :create]

	def new
		@user = current_user
		@users = current_user.friends
		@message = Message.new
	end
	def create
		@recipients = params[:message][:recipient_id]
		@title = params[:message][:title]
		#@image = params[:message][:image]
		@recipients.each do |r|
		@message = current_user.sent_messages.build(:recipient_id => r, :title => @title)
		@message.save
		end
		if @message.errors.any?
			flash[:error] = "Can not create message, title and recipient can not empty"
			redirect_to new_user_message_path(current_user)
		else
			flash[:notice] = "create message success"
			redirect_to root_path
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
