class Api::V1::ClientsController < ApplicationController  
  before_action :set_client, only: [:show, :update, :destroy]
  
  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
    render json: @clients
  end
  
  # GET /clients/:id
  # GET /clients/:id.json
  def show
    if !@client.nil?
      render json: @client
    else
      render json: {message: 'Client not found'}, status: :not_found
    end
  end
  
  # POST /clients
  # POST /clients.json
  def create 
    @client = Client.new(client_params)
    if @client.save
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /clients/:id
  # PATCH/PUT /clients/:id.json
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end
  
  #DELETE /clients/:id
  #DELETE /clients/:id.json
  def destroy
    @client.destroy
    render json: @client
  end
  
  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.where("id = :id OR short_code = :id", {id: params[:id]}).take
    end
    
    # allow client paramaters
    def client_params
      params.permit(:name, :address, :phone, :website, :short_code)
    end
  
   
end