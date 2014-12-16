require 'rails_helper'

describe Comment, :type => :model do
  before { @comment = Comment.make! }

  it 'is valid' do
    expect @comment.valid?
  end

  it 'validates presence of body' do
    @comment.body = nil
    expect !@comment.valid?
  end

  it 'has at least a 3 character body' do
    @comment.body = 'no'
    expect !@comment.valid?
  end

  it 'validates presence of commenter' do
    @comment.commenter = nil
    expect !@comment.valid?
  end
end
