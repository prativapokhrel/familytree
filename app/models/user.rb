class User < ApplicationRecord 
  belongs_to :parent, class_name: "User", optional: true
  has_many :sons, class_name: "User", foreign_key: 'parent_id' 
  has_one :uploaded_file

  scope :grand_parents, -> { where(parent_id: nil) }
end 