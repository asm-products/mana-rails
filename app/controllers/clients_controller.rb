class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  def index
    if params[:letter]
      @clients = Client.find_by_first_letter(params[:letter]).order('name ASC').paginate(:page => params[:page])
    else
      @clients = Client.order('name ASC').paginate(:page => params[:page])
    end
  end
  
  def show
  end
  
  def new
    @client = Client.new
  end
  
  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to client_path(@client.short_code)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @client.update(client_params)
      redirect_to client_path(@client.short_code)
    else
      render 'edit'
    end
  end
  
  def destroy
    @client.destroy
    redirect_to clients_path
  end
  
  private
    
    def set_client
      @client = Client.find_by(id: params[:id]) || Client.find_by(short_code: params[:id])
    end
    
    def client_params
      params.require(:client).permit(:name, :address, :phone, :website, :short_code)
    end
  
end
