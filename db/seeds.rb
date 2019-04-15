# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
csv = CSV.read("public/family.csv", :headers => false)
csv.each_with_index do |row,i|
  next if i == 0
  r = row.join(', ').split(/\t/)
  grand_father = User.where(name: r[0]).first_or_create(address_line_1: r[3], address_line_2: r[4], street_code: r[5])
  
  unless grand_father.blank?
    father = grand_father.sons.where(name: r[1], parent_id: grand_father.id).first_or_create(address_line_1: r[3], address_line_2: r[4], street_code: r[5])
    father.sons.where(name: r[2], parent_id: father.id).first_or_create(address_line_1: r[3], address_line_2: r[4], street_code: r[5])
  end
end
