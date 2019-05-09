class Photo < ApplicationRecord
	belongs_to :pet
	has_one_attached :pet_image
end
