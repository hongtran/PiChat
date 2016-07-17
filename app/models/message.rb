class Message < ApplicationRecord
	#attr_accessible :image, :remote_image_url
	belongs_to :sender, class_name: 'User'
	belongs_to :recipient, class_name: 'User'
	validates :title, presence: true
	validates :recipient_id, presence: true
	mount_uploader :image, AvatarUploader
	scope :unread, -> {where(read_at: nil)}

	def mark_as_read!
		self.read_at = Time.now
		save!
	end

	def read?
		read_at
	end
end
