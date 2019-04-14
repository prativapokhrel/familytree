class User < ApplicationRecord 
  belongs_to :parent, class_name: "User", optional: true
  belongs_to :grand_parent, class_name: "User", foreign_key: 'grandparent_id', optional: true
  has_many :sons, class_name: "User", foreign_key: 'parent_id' 
  has_one :file

end 