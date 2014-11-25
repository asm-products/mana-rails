class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client_contact, only: [:show, :edit, :update, :destroy]
   
  def show
  end
  
  def new
    @client = Client.find_by(id: params[:client_id]) || Client.find_by(short_code: params[:client_id])
    @contact = User.new
  end
  
  def create
    @client = Client.find_by(id: params[:client_id]) || Client.find_by(short_code: params[:client_id])
    @contact = User.new(contact_params)
    @contact.client_id = @client.id
    if @contact.save
      redirect_to client_contact_path(@client.short_code, @contact.name)
    else
      render 'new'
    end
  end
  
  def edit
    redirect_to edit_users_profile_path(@contact)
  end
  
  def update
    if @contact.update(contact_params)
      redirect_to client_contact_path(@client.short_code, @contact.name)
    else
      render 'edit'
    end
  end
  
  def destroy
    # Don't actually destroy the user, remove them from the client
    @contact.update_attribute(:client_id, nil)
    redirect_to client_path(@client.short_code)
  end

  private
  
  def set_client_contact
    @client = Client.find_by(id: params[:client_id]) || Client.find_by(short_code: params[:client_id])
    @contacts = User.where(client_id: @client.id)
    @contact = @contacts.find_by(id: params[:id]) || @contacts.find_by(name: params[:id])
  end
  
  def contact_params
    params.require(:user).permist(:name, :email, :password, :password_confirmation)
  end
end
