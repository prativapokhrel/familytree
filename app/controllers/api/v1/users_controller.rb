class Api::V1::UsersController < Api::V1::BaseController
  respond_to :json
  def index
    @users = User.all
    render json: @users
  end
  
  def create
    file = UploadedFile.new(file_name: params[:file])
    if file.save
      UserWorker.perform_async(file.id)
      render json: { status: :success }
    else 
      render :json => {  status: :error, :errors => file.errors.full_messages }

    end 
  end 


  def show
    @user = User.find(params[:id])
    render '/api/v1/users/show'

  end
end