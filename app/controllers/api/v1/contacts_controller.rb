class Api::V1::ContactsController < ApplicationController
  
  # GET clients/:client_id/contacts/
  # GET clients/:client_id/contacts.json
  def index
    @contacts = User.where(client_id: client_id)
    render json: @contacts, except: [:password_digest, :remember_digest]
  end
  
  # GET clients/:client_id/contacts/:id
  # GET clients/:client_id/contacts/:id.json
  def show
    if @contact
      render json: @contact, except: [:password_digest, :remember_digest]
    else
      render json: {message: 'Contact not found'}, status: :not_found
    end    
  end
  
  # POST clients/:client_id/contacts
  # POST clients/:client_id/contacts.json
  def create
    @client = Client.find_by(id: client_id) || Client.find_by(short_code: client_id)
    @contact = User.new(contact_params)
    @contact.client_id = client_id
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
  #allow contact parameters
  def contact_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def client_id
    params[:client_id]
  end
end
