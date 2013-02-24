class RemindAppointment
  @queue = :phone

  def self.perform( apppointment_id )

    @appointment = Appointment.find( apppointment_id )
    @user = @appointment.user

    TWILIO_ACCOUNT.calls.create(
        :from => '+16047575181',
        :to => @user.phone,
        :url => "http://dashboard.healthcan.net/twilio/voice?appointment_id=#{@appointment.id}"
    )
  end
end