class Project < ActiveRecord::Base
  include StringHelper
  
  belongs_to :client
  belongs_to :team
  before_save :default_values
  before_validation :generate_unique_short_code
  
  has_one :client
  has_many :issues
  
  validates :name, presence: true, length: { minimum: 4 }
  validates :short_code, length: { minimum: 2 }, allow_blank: true,
            uniqueness: {scope: :team}
  validate :check_client_exists

  def shortcode
    short_code
  end
  
  def default_values
    self.projected_hours ||= 0.0
    self.short_code = short_code.present? ? self.short_code.downcase : self.name[0..1].downcase
    self.short_code = self.short_code.parameterize
    if Project.where(short_code: self.short_code).take.nil?
      self.short_code = generate_unique_short_code
    end
  end
  
  def generate_unique_short_code
    random_string(5)
  end
  
  def check_client_exists
      errors.add(:client_id, 'Client does not exist') if (Client.where(id: self.client_id).take.nil?) if !self.client_id.nil?
  end

  def self.find_by_shortcode(shortcode)
    find_by(short_code: shortcode)
  end

  def self.find_by_id(id)
    find_by(id: id)
  end  
end
