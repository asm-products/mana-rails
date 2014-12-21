module ApiHelper
  # Authenticate user with API key
  def authenticate_api
    api_key = request.headers['X-Api-Key']
    @user = User.where(api_key: api_key).first if api_key
     
    unless @user
      head status: :unauthorized
      return false
    end
  end
end
