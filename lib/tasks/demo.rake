namespace "demo" do

  desc "Generate the Providers"
  task :generate_providers => :environment do
    Provider.create(:name => "Dr. Smith", :phone => "16045550001")
    Provider.create(:name => "Dr. Jones", :phone => "16045550002")
  end

  desc "Generate a User"
  task :generate_user => :environment do
    user = User.create!(:name => "testuser", :email=>"test@email.com" ,:password =>"dummypassword", :password_confirmation => "dummypassword")
  end

  desc "Request Access for a provider"
  task :request_access => :environment do

    provider = Provider.first

    User.each do |user|
      user.requests.create(:provider => provider)
    end
  end


  desc "Notify of New Appointment"
  task :notify_appointment => :environment do

    provider = Provider.first

    User.each do |user|
      user.requests.create(:provider => provider)
    end
  end

  desc "Remind Appointment"
  task :remind_appointment => :environment do

    User.each do |user|
      appointment = user.appointments.first
      Resque.enqueue(RemindAppointment, appointment.id) unless appointment.nil?
    end
  end

end
