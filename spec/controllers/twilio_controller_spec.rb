require 'spec_helper'

describe TwilioController do

  describe "POST 'text'" do
    it "should check for invalid email" do

      post 'text', {:From => "+16045061301", :To => "+16042106329", :Body => "12"}

      response.body.should include("email is invalid")
    end
  end

  describe "POST 'text'" do
    it "should register with valid email" do
      post 'text', {:From => "+16045061301", :To => "+16042106329", :Body => "imackinn@gmail.com"}

      response.should be_success
      User.count.should be( 1 )
      Appointment.count.should be( 2 )
    end
  end

end
