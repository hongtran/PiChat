class User < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true, uniqueness: {case_insensitive: false}
	has_secure_password
	has_many :friendships
	has_many :friends, :through => :friendships
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user

	def received_messages
		Message.where(recipient_id: self)
	end

	def sent_messages
		Message.where(sender_id: self)
	end

	def lastest_received_messages(n)
		received_messages.order(created_at: :desc).limit(n)
	end

	def unread_messages
		received_messages.unread
	end

end
