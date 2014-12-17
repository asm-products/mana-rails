require 'rails_helper'

describe Contact, :type => :model do
  before {@contact = Contact.make! }

  it 'is valid' do
    expect @contact.valid?
  end

  it 'validates presence of name' do
    @contact.name = nil
    expect !@contact.valid?
  end

  it 'has at max a 50 character name' do
    50.times { @contact.name += 'a' }
    expect !@contact.valid?
  end
  it 'validates presence of email' do
    @contact.email = nil
    expect !@contact.valid?
  end

  it 'validates length of email' do
    255.times { @contact.email += 'm' }
    expect !@contact.valid?
  end

  it 'validates format of email' do
    @contact.email = 'testtest.com'
    expect !@contact.valid?
  end

  it 'validates length of password' do
    @contact.password = '123'
    expect !@contact.valid?
  end

  it 'checks for admin' do
    @contact.admin = true
    expect @contact.admin?
  end

  it 'revokes admin access' do
    @contact.admin = true

    @contact.revoke_admin
    expect !@contact.admin?
  end

  it 'revokes admin access and saves' do
    @contact.admin = true

    @contact.revoke_admin!
    expect !@contact.admin?
  end

  it 'adds admin access' do
    @contact.admin = true

    @contact.make_admin
    expect @contact.admin?
  end

  it 'adds admin access and saves' do
    @contact.admin = true

    @contact.make_admin!
    expect @contact.admin?
  end
  
  it 'validate presence of client' do
    @contact.client = nil

    expect !@contact.valid?
  end

  it 'belongs to client' do
    expect @contact.respond_to? :client
  end
end