class Contact < User
  def to_param #overrides
    name
  end
  belongs_to :client
  has_many :comments, as: :commentable

  before_validation :default_values

  validates :client_id, presence: true

  def default_values
    self.name = name.nil? ? generate_temp_username : name
    self.password = password.nil? ? SecureRandom.base64.tr('+/=', 'Qrt') : password
    self.password_confirmation = password_confirmation.nil? ? self.password : password_confirmation
  end

  def generate_temp_username
    (self.client.short_code + '_guest_' + (self.client.contacts.count + 1).to_s).parameterize
  end
end