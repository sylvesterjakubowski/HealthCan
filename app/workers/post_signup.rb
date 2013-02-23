class PostSignup
  @queue = :user

  def self.perform( user_id )

    @user = User.find( user_id )
    @user.reset_authentication_token!

    #setup 2 appointments for user

    if Provider.count < 2
      Rake::Task['demo:generate_providers'].invoke
    end
    @user.approved_providers << Provider.first.id

    Appointment.create_oncologist( @user, Provider.first )
    Appointment.create_labwork( @user, Provider.first )

    @message = "Welcome to HealthCan! You can access your dashboard here: #{ApplicationController.get_hostname}#{dashboard_path(:auth_token => @user.authentication_token)}"

    unless Rails.env.test? || @user.phone.nil?
      TWILIO_ACCOUNT.sms.messages.create(
          :from => '+16047575181',
          :to => user.phone,
          :body => @message
      )
    end


  end
end