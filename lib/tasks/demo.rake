namespace "demo" do

  desc "Generate the Providers"
  task :generate_providers => :environment do
    Provider.create(:name => "Dr. Smith", :phone => "16045550001")
    Provider.create(:name => "Dr. Jones", :phone => "16045550002")

  end

end
