class Api::V1::ContactsController < ApplicationController
  before_action :set_client_contact, except: [:create]
  before_filter :authenticate_api
  
  # GET clients/:client_id/contacts/
  # GET clients/:client_id/contacts.json
  def index
    render json: @contacts, except: [:password_digest, :remember_digest, :api_key]
  end
  
  # GET clients/:client_id/contacts/:id
  # GET clients/:client_id/contacts/:id.json
  def show
    if !@contact.nil?
      render json: @contact, except: [:password_digest, :remember_digest, :api_key]
    else
      render json: {message: 'Contact not found'}, status: :not_found
    end    
  end
  
  # POST clients/:client_id/contacts
  # POST clients/:client_id/contacts.json
  def create
    @client = Client.find_by(id: client_id) || Client.find_by(short_code: client_id)
    @contact = User.new(contact_params)
    @contact.client_id = @client.id
    if @contact.save
      render json: @contact, except: [:password_digest, :remember_digest, :api_key]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /clients/:client_id/contacts
  # PATCH/PUT /clients/:client_id/contacts.json
  def update
    if @contact.update(contact_params)
      render json: @contact, except: [:password_digest, :remember_digest, :api_key]
    else
      render json: @contact.errors, status: :unprocessable_entity
    end
  end
  
  # DELETE /clients/:client_id/contacts/:id
  # DELETE /clients/:client_id/contacts/:id.json
  def destroy
    # Don't actually destroy the user, just the client user relationship.
    @contact.update_attribute(:client_id, nil)
    render json: @contact, except: [:password_digest, :remember_digest, :api_key]
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_client_contact
    @client = Client.find_by(id: params[:client_id]) || Client.find_by(short_code: params[:client_id])
    @contacts = User.where(client_id: @client.id)
    @contact = @contacts.find_by(id: params[:id]) || @contacts.find_by(name: params[:id])
  end
    
  #allow contact parameters
  def contact_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
  
end
