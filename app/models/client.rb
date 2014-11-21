class Client < ActiveRecord::Base
  before_save :default_values
  
  has_many :contacts
  
  validates :name, presence: true, length: { minimum: 4 }
  validates :short_code, uniqueness: true, length: { minimum: 4, maximum: 6 }, allow_blank: true
  
  def default_values
    self.short_code = self.short_code.present? ? self.short_code.downcase : self.name[0..3].downcase
    self.short_code = self.short_code.parameterize
    if !Client.where(short_code: self.short_code).take.nil?
      self.short_code = generate_unique_short_code
    end
  end
  
  def generate_unique_short_code
    i = 0
    new_short_code = self.short_code
    while !Client.where(short_code: new_short_code).take.nil? do
      i += 1
      new_short_code = self.short_code + i.to_s
      n = self.short_code[0..5].length - i.to_s.length
      new_short_code = new_short_code.length <= 6 ? new_short_code : self.short_code[0..n] + i.to_s 
    end
    return new_short_code
  end
end
