class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client_contact, except: [:create, :new]
   
  def show
  end
  
  def new
    @client = Client.find_by(id: params[:client_id]) || Client.find_by(short_code: params[:client_id])
    @contact = @client.contacts.new
    @profile = UserProfile.new
  end
  
  def create
    @client = Client.find_by(id: params[:client_id]) || Client.find_by(short_code: params[:client_id])
    @contact = @client.contacts.new(contact_params)
    @profile = UserProfile.new(profile_params)
    if @contact.save
      @profile.user = @contact
      @profile.save
      redirect_to client_path(@client.short_code)
    else
      render 'new'
    end
  end
  
  def edit
    redirect_to edit_users_profile_path(@contact)
  end
  
  def update
    if @contact.update(contact_params)
      redirect_to client_user_path(@client.short_code, @contact.name)
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
    @contacts = @client.contacts
    @contact = @contacts.find_by(id: params[:id]) || @contacts.find_by(name: params[:id])
  end
  
  def contact_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def profile_params
    params.require(:user_profile).permit(:first_name, :last_name, :job_title, :phone)
  end
end
