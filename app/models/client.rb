class Client < ActiveRecord::Base
  before_save :default_values
  
  has_many :contacts
  
  validates :name,
    presence: true,
    length: { minimum: 4 }
    
  validates :short_code,
    uniqueness: true, length: { minimum: 4, maximum: 6 },
    allow_blank: true
  
  def short_code=(new_short_code)
      super new_short_code.downcase.parameterize
  end
  
  def unique_short_code=(new_short_code)
      self.short_code = generate_unique_short_code(new_short_code)
  end
  
  def default_values
      if short_code.blank? && name.present?
          self.unique_short_code = self.name[0..3]
    end
  end
  
  def generate_unique_short_code
    i = 0
    generated_short_code = new_short_code
    
    while Client.where(short_code: generated_short_code).exists? do
        i += 1
        generated_short_code = i.to_s.rjust(6, new_short_code)
    end
    
    generated_short_code
  end
end
