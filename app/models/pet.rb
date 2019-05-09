class Pet < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many_attached :images
  
  validates :name, presence: true
  validates :description, presence: true
  validates :animal_type, presence: true
  validates :breed, presence: true
  validate :image_type

  def owned_by(current_user) 
  	return user.id == current_user.id
  end

  def resize_images(image_index)
  	return self.images[image_index].variant(resize: '200X200!').processed
  end

  private 
  	def image_type
  		images.each do |image|
  			if !image.content_type.in?(%('image/jpeg image/jpg image/png'))
  				errors.add(:images, "Needs to be a JPG, JPEG or PNG")
  			end
  		end
  	end
end
