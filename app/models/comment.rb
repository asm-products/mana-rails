class Comment < ActiveRecord::Base
  include MarkdownConcern
  belongs_to :commenter, class_name: 'User'
  belongs_to :commentable, polymorphic: true
	before_save { self.body = capture_mention(body) }

  validates :body, presence: true, length: { minimum: 3 }
  validates :commenter_id, presence: true
end
