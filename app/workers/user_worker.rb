class UserWorker  
  require 'csv'
  include Sidekiq::Worker
  def perform(file_id)
    file = UploadedFile.find(file_id)
    
    csv = CSV.read(file.file_name.path, :headers => false)
    csv.each_with_index do |row,i|
      next if i == 0
      r = row.join(', ').split(/\t/)
      grand_father = User.create!(name: r[0], address_line_1: r[3], address_line_2: r[4], street_code: r[5])
      father = User.create!(name: r[1], parent_id: grand_father.id, address_line_1: r[3], address_line_2: r[4], street_code: r[5])
      son = User.create!(name: r[2], parent_id: father.id, address_line_1: r[3], address_line_2: r[4], street_code: r[5])
    end

    return file 
  end 
end 