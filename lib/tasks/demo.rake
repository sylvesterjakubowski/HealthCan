namespace "demo" do

  desc "Generate the Providers"
  task :generate_providers => :environment do
    Provider.create(:name => "Dr. Smith", :phone => "16045550001")
    Provider.create(:name => "Dr. Jones", :phone => "16045550002")
  end

  desc "Generate a User"
  task :generate_user => :environment do
    User.create!(:name => "testuser", :email=>"test@email.com" ,:password =>"dummypassword", :password_confirmation => "dummypassword")
  end

  desc "Request Access for a provider"
  task :request_access => :environment do

    provider = Provider.first

    User.each do |user|
      user.requests.create(:provider => provider)
    end
  end

end
