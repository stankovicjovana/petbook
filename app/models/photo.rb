class Photo < ApplicationRecord
	belongs_to :pet
	has_one_attached :pet_image

	validates :title, presence: true
	validates :description, presence: true

	validate :correct_image_type
	validate :image_presence


	def resize_image
  		return pet_image.variant(resize: '200X200!').processed
  	end

	private 
	  	def correct_image_type
			if pet_image.attached? && !pet_image.content_type.in?(%('pet_image/jpeg pet_image/jpg pet_image/png'))
				errors.add(:photos, "Needs to be a JPG, JPEG or PNG")
			end
	  	end

	  	def image_presence
	  		unless pet_image.attached?
	  			errors.add(:photos, "Need to attach an image")
	  		end
	  	end
end
