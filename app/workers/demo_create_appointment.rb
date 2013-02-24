class DemoCreateAppointment
  @queue = :user

  def self.perform( user_id )
    user = User.find( user_id )
    appointment = Appointment.create_radiation( user, Provider.all[1] )
    Resque.enqueue(NotifyAppointment, appointment.id)
  end

end