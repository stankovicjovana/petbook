class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def is_current_user(session_id)
  	if self.id == session_id
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
end
