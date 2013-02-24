class UserMailer < ActionMailer::Base
  include Resque::Mailer

  default from: "HealthCan <no-reply@healthcan.net>"

  def welcome_email( user_id )
    @user = User.find( user_id )

    @url  = "http://dashboard.healthcan.net"

    mail(:to => user.email, :subject => "Welcome to HealthCan.net")


  end

end
