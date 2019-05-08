class User < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_one_attached :profile_image
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def is_current_user(session_user_id)
  	if self.id == session_user_id
  		puts "****"
  		puts "CURRENT USER"
  		puts "****"

  		return true
  	else
  		puts "****"
  		puts "NOT CURRENT USER"
  		puts "****"

  		return false
  	end
  end

  def has_no_pets
    pets.count < 1
  end
end
