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

      response.body.should include("Welcome to")
      User.count.should be( 1 )
    end
  end

end
