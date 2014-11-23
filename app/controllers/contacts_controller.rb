class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client_contact, only: [:show, :edit, :update, :destroy]
   
  def show
  end
  
  def new
    @client = Client.find_by("id = :id OR short_code = :id", {id: params[:client_id]})
    @contact = User.new
  end
  
  def create
    @client = Client.find_by("id = :id OR short_code = :id", {id: params[:client_id]})
    @contact = User.new(contact_params)
    @contact.client_id = @client.id
    if @contact.save
      redirect_to client_contact_path(@client.short_code, @contact.name)
    else
      render 'new'
    end
  end
  
  def edit
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
    @client = Client.find_by("id = :client_id OR short_code = :client_id", {client_id: params[:client_id]})
    @contact = User.find_by("client_id = :client_id AND (id = :id OR name = :id)", {client_id: @client.id, id: params[:id]})
  end
  
  def contact_params
    params.require(:user).permist(:name, :email, :password, :password_confirmation)
  end
end
