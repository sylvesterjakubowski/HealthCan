class NotifyAppointment
  @queue = :user

  def self.perform( appointment_id )

    @appointment = Appointment.find( appointment_id )
    @user = @appointment.user
    @message = "#{@appointment.provider.name } has scheduled an appointment for your on #{@appointment.time.to_time.strftime("%Y/%m/%d at %I:%M%p")}. #{ApplicationController.get_hostname}#{Rails.application.routes.url_helpers.dashboard_path(:auth_token => @user.authentication_token)}"

    TWILIO_ACCOUNT.sms.messages.create(
        :from => '+16047575181',
        :to => @user.phone,
        :body => @message
    )
  end
end