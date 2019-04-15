class UserWorker  
  require 'csv'
  include Sidekiq::Worker

  def perform(file_id)
    file = UploadedFile.find(file_id)
    
    csv = CSV.read(file.file_name.path, :headers => false)
    csv.each_with_index do |row,i|
      next if i == 0
      r = row.join(', ').split(/\t/)
      grand_father = User.where(name: r[0]).first_or_create(address_line_1: r[3], address_line_2: r[4], street_code: r[5])
      
      unless grand_father.blank?
        father = grand_father.sons.where(name: r[1], parent_id: grand_father.id).first_or_create(address_line_1: r[3], address_line_2: r[4], street_code: r[5])
        father.sons.where(name: r[2], parent_id: father.id).first_or_create(address_line_1: r[3], address_line_2: r[4], street_code: r[5])
      end
    end

  end
end