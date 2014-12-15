class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.commenter = current_user
    if @comment.save
      flash[:success] = 'Note Saved!'
      redirect_to :back
    else
      flash[:danger] = 'Comment ' + @comment.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:subject, :body)
    end

    def find_commentable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end
