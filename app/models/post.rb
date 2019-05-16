class Post < ApplicationRecord
	belongs_to :user
	has_one_attached :users_photo

	validate :empty_post

	def does_belongs_to(user)
		unless user_id == user.id
			return false
			puts "******************************"
			puts "POST DOES NOT BELONG TO USER!"
			puts "******************************"
		end
		true
	end

	private 
		def empty_post
			unless body.present? or users_photo.attached?
				errors.add(:post, "post is empty")
			end
		end

		
end
