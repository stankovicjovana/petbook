class Post < ApplicationRecord
	belongs_to :user
	has_one_attached :users_photo

	validate :empty_post

	private 
		def empty_post
			unless body.present? or users_photo.attached?
				errors.add(:post, "post is empty")
			end
		end
end
