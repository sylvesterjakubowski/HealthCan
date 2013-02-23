require 'spec_helper'

describe RequestController do

  describe "GET 'index'" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      sign_in( user )
      get 'index'
      response.should be_success
    end
  end

  describe "POST 'approve'" do
    it "returns http success" do

      user = FactoryGirl.create(:user)
      provider = FactoryGirl.create(:jones)

      request = user.requests.create(:provider => provider)

      sign_in( user )

      post 'approve', :id => request.id

      user.reload
      user.approved_providers.should include( provider.id )
    end
  end

end
