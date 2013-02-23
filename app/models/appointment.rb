class Appointment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  belongs_to :provider

  field :time, :type => DateTime
  field :subject, :type => String

  field :venue, :type => String
  field :loc, :type => Array

  field :reminders, :type => String

  embeds_many :appointment_comments

  field :video_link, :type => String


end