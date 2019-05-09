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

end
