class Message < ActiveRecord::Base
	default_scope -> { order('created_at DESC') }
	belongs_to :sender, class_name: "User"
	belongs_to :receiver, class_name: "User"

	validates_presence_of :content, :receiver_id, :sender_id
end
