class UserMailer < ActionMailer::Base
  include Resque::Mailer
  include Rails.application.routes.url_helpers

  default from: "HealthCan <no-reply@healthcan.mailgun.org>"

  def welcome_email( user_id )
    @user = User.find( user_id )

    mail(:to => @user.email, :subject => "Welcome to HealthCan.net")
  end

end
