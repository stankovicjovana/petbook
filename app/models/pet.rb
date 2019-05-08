class Pet < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :description, presence: true
  validates :animal_type, presence: true
  validates :breed, presence: true
  has_many_attached :images
  def owned_by(current_user) 
  	return user.id == current_user.id
  end
end
