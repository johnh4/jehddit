class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	has_many :replies, class_name: "Comment", foreign_key: "op_id"
	belongs_to :op, class_name: "Comment"

	validates_presence_of :content, :user_id, :post_id
	validates :vote_count, numericality: { only_integer: true }
end
