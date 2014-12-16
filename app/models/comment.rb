class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  validates :body, presence: true, length: { minimum: 3 }
  validates :commenter_id, presence: true
end
