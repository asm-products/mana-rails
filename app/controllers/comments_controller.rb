class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_filter :load_commentable

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.commenter = current_user
    if @comment.save
      flash[:success] = 'Comment Saved!'
      redirect_to @commentable
    else
      flash[:danger] = 'Comment ' + @comment.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:subject, :body)
    end

    def load_commentable
      resource, id = request.path.split('/')[1, 2]
      @commentable = resource.singularize.classify.constantize.find_by_params(id)
    end
end
