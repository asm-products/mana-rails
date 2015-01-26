class Client < ActiveRecord::Base

  def to_param #override
    short_code_was
  end

  before_save :default_values
  phony_normalize :phone

  belongs_to :team
  has_many :contacts
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, presence: true, length: { minimum: 4 }
  validates :short_code, presence: true, length: { minimum: 4 },
            uniqueness: {scope: :team}
  validates :phone, length: {minmum: 10, maximum: 10}, allow_blank: true

  def default_values
    self.short_code = self.short_code.parameterize
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

  def self.find_by_first_letter(letter)
    where('name LIKE ?', "#{letter}%").order('name ASC')
  end

  def self.find_by_params(param)
    find_by(short_code: param)
  end
end
