class UserMailer < ActionMailer::Base
  default from: "noreply@getmana.io"

  def verify_email(user)
    @user = user
    @url = user_verify_path(@user.special_key).to_s
  end
end
