class Pet < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: "Pet", optional: true
  has_many :children, class_name: "Pet", foreign_key: "parent_id"
  has_many :photos, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true
  validates :animal_type, presence: true
  validates :breed, presence: true
  

  def owned_by(current_user) 
  	return user.id == current_user.id
  end

  def parent_name
    parent.try(:name)
  end

  def has_parent?
    parent.present?
  end

  def has_children?
    childern.exists?
  end
end
