module ApiHelper
  # Authenticate user with API key
  def authenticate_api
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(api_key: token).first
    end
  end
end
