module MessagesHelper
	def unread_messages
		current_user.received_messages.where(unread: true)
	end
	def unread?
		unread_messages.any?
	end
end
