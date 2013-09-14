class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	has_many :posts
	has_many :comments, through: :posts
	
	#has_many :messages, foreign_key: "receiver_id"
	#has_many :received_messages, through: :messages, source: :receiver
#
	#has_many :reverse_messages, class_name: "Message", foreign_key: "sender_id"
	#has_many :sent_messages, through: :reverse_messages, source: :sender

	has_many :messages

	validates :name, presence: true, uniqueness: { case_sensitive: false }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i 
	validates :email, presence: true, uniqueness: { case_sensitive: false },
					  format: { with: VALID_EMAIL_REGEX }
	
	has_secure_password					  

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def sent_messages
		Message.where(sender_id: self.id)
	end

	def received_messages
		Message.where(receiver_id: self.id)
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end

end
