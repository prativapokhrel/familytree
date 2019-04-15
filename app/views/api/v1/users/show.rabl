object @user

attributes :id, :name, :address_line_1, :address_line_2, :street_code

child :parent => :parent do
 attributes :id, :name
end

child :parent => :grand_parent do
  child :parent => :grand_parent do
    attributes :id, :name
  end
end

child :sons => :sons do
  attributes :id, :name
  child :sons => :sons do
    attributes :id, :name
  end
end

node :is_grandparent do
  @user.parent_id.blank? && @user.sons.present?
end

node :is_parent do 
  @user.sons.present? && @user.parent_id.present?
end

node :is_grandchild do
  @user.sons.blank?
end