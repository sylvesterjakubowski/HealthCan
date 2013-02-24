class Appointment
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActionView::Helpers::DateHelper

  belongs_to :user

  belongs_to :provider

  field :time, :type => DateTime
  field :subject, :type => String

  field :venue, :type => String
  field :loc, :type => Array

  field :description, :type => String
  field :reminders, :type => String

  embeds_many :appointment_comments

  field :video_link, :type => String

  #demo data appointments
  def self.create_oncologist( user, provider )
    appointment = Appointment.create( :user => user, :provider => provider) do |u|
      u.subject = "Oncologist"
      u.time = 2.days.from_now
      u.description = "Oncologist (doctors who specialize in cancer treatment. Oncologists study your cancer and make recommendations for treatment. An oncologist will likely specialize in one of two types of treatment -- radiation therapy or systemic (drug) therapy)"
      u.venue = "600 W 10th Ave, Vancouver, BC V5Z 4E6"
      u.reminders = "If possible, please bring a caregiver or support person to this appointment"
    end

    return appointment
  end

  def self.create_labwork( user, provider )
    appointment = Appointment.create( :user => user, :provider => provider) do |u|
      u.subject = "Lab work - blood test"
      u.time = 3.days.from_now
      u.description = "The purpose of this blood test is to make sure your kidneys will be able to get rid of the dye. Not getting this blood test will delay your CAT scan appointment."
      u.venue = "100 W 10th Ave, Vancouver BC"
      u.reminders = "No special instructions before the test. Note: This test must be completed before the CAT scan."
    end

    return appointment
  end

  def self.create_catscan( user, provider )
    appointment = Appointment.create( :user => user, :provider => provider) do |u|
      u.subject = "CAT Scan- with contrast dye"
      u.time = 5.days.from_now
      u.description = "Definition: A CAT scan uses X-rays and computers to produce an image of a cross-section of the body. This image allows your doctor to check for swollen or enlarged lymph nodes, which might mean that cancer has spread."
      u.venue = "600 Broadway Ave. Vancouver BC"
      u.reminders = "If you have an allergy to contrast dye, notify your physician immediately. Only clear liquids after midnight before your scan. Clear liquids are liquids you can see through. These include clear broth, tea, strained fruit juices, strained vegetable soup, black coffee, plain Jell-O, tomato juice, and ginger ale."
      u.video_link = "http://www.youtube.com/watch?v=M-4o0DxBgZk"
    end

    return appointment
  end

  def self.create_radiation( user, provider )
    appointment = Appointment.create( :user => user, :provider => provider) do |u|
      u.subject = "Radiation Oncologist"
      u.time = 2.weeks.from_now
      u.description = "Added appointment: Radiation Oncologist (are specialists who work with the health-care team to plan and monitor your radiation therapy treatment)"
      u.venue = "600 Broadway Ave. Vancouver BC"
      u.reminders = "If possible, please bring a caregiver or support person to this appointment"
      u.video_link = "http://www.youtube.com/watch?v=M-4o0DxBgZk"
    end

    return appointment
  end

  def to_xml(options={})

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.Response {
        xml.Pause(:length =>'3')
        xml.Say "This is a reminder for your #{self.subject} appointment in #{distance_of_time_in_words(Time.now, self.time)}. Be sure to vote for Hacking Health entry number 18, healthcan.net "
      }
    end

    builder.to_xml
  end

end