namespace "demo" do

  desc "Generate the Providers"
  task :generate_providers => :environment do
    Provider.create(:name => "Dr. Smith", :phone => "16045550001")
    Provider.create(:name => "Dr. Jones", :phone => "16045550002")

  end

  desc "Generate a User"
  task :generate_user => :environment do
    User.create!(:name => "testuser", :email=>"test@email.com" ,:password =>"dummypassword", :password_confirmation => "dummypassword", :phone => "16045550001")

  end

end
