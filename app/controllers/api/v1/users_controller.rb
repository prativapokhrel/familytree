class Api::V1::UsersController < Api::V1::BaseController
  include Sidekiq::Status::Worker
  require 'csv'    
  def index 
    binding.pry 
    @user = User.all 
    render json: @user 
  end  

  def create 
    file = UploadedFile.create(file_name: params[:file])
    job_id = UserWorker.perform_async(file.id)
    render json: User.all 
    # status = Sidekiq::Status::get_all job_id
    

    # csv = CSV.read(params[:file].tempfile, :headers => false)
    # csv.each_with_index do |row,i|
    #   next if i == 0
    #   r = row.join(', ').split(/\t/)
    #   grand_father = User.create!(name: r[0], address_line_1: r[3], address_line_2: r[4], street_code: r[5])
    #   father = User.create!(name: r[1], parent_id: grand_father.id, address_line_1: r[3], address_line_2: r[4], street_code: r[5])
    #   son = User.create!(name: r[2], parent_id: father.id, address_line_1: r[3], address_line_2: r[4], street_code: r[5])
    # end


  end 

  def show 
    binding.pry 
  end 

end 