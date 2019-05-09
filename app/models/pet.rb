class Pet < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true
  validates :animal_type, presence: true
  validates :breed, presence: true
  

  def owned_by(current_user) 
  	return user.id == current_user.id
  end

  def resize_images(image_index)
  	return self.images[image_index].variant(resize: '200X200!').processed
  end

  
end
