class NotifyAppointment
  @queue = :user

  def self.perform( appointment_id )

    @appointment = Appointment.find( appointment_id )
    @user = @appointment.user

    @message = "#{@request.provider.name } is requesting permissions to your HealthCan dashboard, you can approve it here here: #{ApplicationController.get_hostname}#{Rails.application.routes.url_helpers.dashboard_path(:auth_token => @user.authentication_token)}"

    TWILIO_ACCOUNT.sms.messages.create(
        :from => '+16047575181',
        :to => @user.phone,
        :body => @message
    )
  end
end