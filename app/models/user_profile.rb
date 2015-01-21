class UserProfile < ActiveRecord::Base
  belongs_to :user
  phony_normalize :phone
  
  validates :phone, length: {minmum: 10, maximum: 10}, allow_blank: true

  def area_code
    phone == nil ? '' : phone.first(3)
  end

  def phone_prefix
    phone == nil ? '' : phone.slice(3,3)
  end

  def phone_suffix
    phone == nil ? '' : phone.last(4)
  end
end
