class Project < ActiveRecord::Base
  belongs_to :client
  belongs_to :team
  before_save :default_values
  
  has_one :client
  has_many :issues
  
  validates :name, presence: true, length: { minimum: 4 }
  validates :short_code, uniqueness: true, length: { maximum: 4 }, allow_blank: true
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
    i = 0
    new_short_code = self.short_code
    while !Project.where(short_code: new_short_code).take.nil? do
      i += 1
      new_short_code = self.short_code + i.to_s
      n = self.short_code[0..3].length - i.to_s.length
      new_short_code = new_short_code.length < 4 ? new_short_code : self.short_code[0..n] + i.to_s
    end
    return new_short_code
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
