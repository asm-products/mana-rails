class Comment < ActiveRecord::Base
  include MarkdownConcern
	
	def to_param #overrides
		slug
	end
	
  belongs_to :commenter, class_name: 'User'
  belongs_to :commentable, polymorphic: true
	before_save :default_values

  validates :body, presence: true, length: { minimum: 3 }
  validates :commenter_id, presence: true
	
	def default_values
		self.body = capture_mention(body)
		self.slug ||= SecureRandom.uuid
	end
	
	def find_by_slug slug
		find_by(slug: slug)
	end
end
