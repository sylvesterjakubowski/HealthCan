class PostSignup
  @queue = :user

  def self.perform( user_id )

    @user = User.find( user_id )
    @user.reset_authentication_token!

    #setup 2 appointments for user

    if Provider.count < 3
      Provider.create(:name => "Dr. Smith", :phone => "16045550001")
      Provider.create(:name => "Dr. Jones", :phone => "16045550002")
      Provider.create(:name => "Dr. House", :phone => "16045550003")
    end

    @user.approved_providers << Provider.first.id
    @user.approved_providers << Provider.all[1].id

    Appointment.create_oncologist( @user, Provider.first )
    Appointment.create_labwork( @user, Provider.first )
    Appointment.create_catscan( @user, Provider.all[1] )

    @message = "Welcome to HealthCan! You can access your dashboard here: #{ApplicationController.get_hostname}#{Rails.application.routes.url_helpers.dashboard_path(:auth_token => @user.authentication_token)}"

    #unless Rails.env.test? || @user.phone.nil?
    #  TWILIO_ACCOUNT.sms.messages.create(
    #      :from => '+16047575181',
    #      :to => @user.phone,
    #      :body => @message
    #  )
    #end

    Resque.enqueue(DemoCreateAppointment, @user.id)
    Resque.enqueue_in( 3.minutes, DemoAuthRequest, @user.id)
    #UserMailer.welcome_email( User.first.id ).deliver

  end
end