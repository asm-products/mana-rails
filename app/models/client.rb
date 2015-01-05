class Client < ActiveRecord::Base
  def to_param #override
    self.short_code
  end

  before_save :default_values
  phony_normalize :phone

  belongs_to :team
  has_many :contacts
  has_many :comments, as: :commentable

  validates :name, presence: true, length: { minimum: 4 }
  validates :short_code, uniqueness: true, length: { minimum: 4, maximum: 6 },
    allow_blank: true
  validates :phone, length: {minmum: 10, maximum: 10}, allow_blank: true
  
  def default_values
    if short_code.blank? && name.present?
      self.unique_short_code = self.name[0..3].downcase.strip
    end
  end

  def short_code=(new_short_code)
    super new_short_code.downcase.parameterize
  end

  def unique_short_code=(new_short_code)
    self.short_code = generate_unique_short_code(new_short_code)
  end

  def generate_unique_short_code(new_short_code)
    i = 0
    generated_short_code = new_short_code

    while Client.where(short_code: generated_short_code).exists? do
      i += 1
      generated_short_code = i.to_s.rjust(6, new_short_code)
    end
    
    generated_short_code
  end
  
  def area_code
    phone == nil ? '' : phone.first(3)
  end
  
  def phone_prefix
    phone == nil ? '' : phone.slice(3,3)
  end
  
  def phone_suffix
    phone == nil ? '' : phone.last(4)
  end
  
  def formatted_phone
    phone == nil ? '' : '(' + area_code + ') ' + phone_prefix + '-' + phone_suffix
  end
  
  def self.find_by_first_letter(letter)
    where('name LIKE ?', "#{letter}%").order('name ASC')
  end
end
