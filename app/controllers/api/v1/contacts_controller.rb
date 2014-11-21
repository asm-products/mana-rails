class Api::V1::ContactsController < ApplicationController
  before_action :set_client_contact, only: [:index, :show, :update, :destroy]
  
  # GET clients/:client_id/contacts/
  # GET clients/:client_id/contacts.json
  def index
    @contacts = User.where(client_id = @client.id)
    render json: @contacts, except: [:password_digest, :remember_digest]
  end
  
  # GET clients/:client_id/contacts/:id
  # GET clients/:client_id/contacts/:id.json
  def show
    if !@contact.nil?
      render json: @contact, except: [:password_digest, :remember_digest]
    else
      render json: {message: 'Contact not found'}, status: :not_found
    end    
  end
  
  # POST clients/:client_id/contacts
  # POST clients/:client_id/contacts.json
  def create
    @client = Client.where("id = :client_id OR short_code = :client_id", {client_id: params[:client_id]}).take
    @contact = User.new(contact_params)
    @contact.client_id = @client.id
    if @contact.save
      render json: @contact, except: [:password_digest, :remember_digest]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /clients/:client_id/contacts
  # PATCH/PUT /clients/:client_id/contacts.json
  def update
    if @contact.update(contact_params)
      render json: @contact, except: [:password_digest, :remember_digest]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /clients/:client_id/contacts/:id
  # DELETE /clients/:client_id/contacts/:id.json
  def destroy
    @contact.destroy
    render json: @contact, except: [:password_digest, :remember_digest]
  end
  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_client_contact
      @client = Client.where("id = :client_id OR short_code = :client_id", {client_id: params[:client_id]}).take
      @contact = User.where("client_id = :client_id AND (id = :id OR name = :id)", {client_id: @client.id, id: params[:id]}).take
    end
    
    #allow contact parameters
    def contact_params
      params.permit(:name, :email, :password, :password_confirmation)
    end  
end
