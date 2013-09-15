class Post < ActiveRecord::Base
	default_scope -> { order('vote_count DESC') }
	belongs_to :user
	has_many :comments, dependent: :destroy

	validates :content, presence: true
	validates :user_id, presence: true
	validates :title, presence: true, length: { maximum: 100 }
end
