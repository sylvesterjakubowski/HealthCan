class AppointmentComment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :appointment
  belongs_to :user

  field :comment

end