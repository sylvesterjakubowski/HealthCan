class TwilioController < ApplicationController

  #test number for tunnel is 604-210-6329
  #SmsSid	A 34 character unique identifier for the message. May be used to later retrieve this message from the REST API.
  #AccountSid	The 34 character id of the Account this message is associated with.
  #From	The phone number that sent this message.
  #To	The phone number of the recipient.
  #Body	The text body of the SMS message. Up to 160 characters long.
  #http://www.twilio.com/docs/api/twiml/sms/twilio_request
  def text
    logger.info "SMS REQUEST FROM  #{params['From']} to #{params["To"]} in #{params['FromCity']}, #{params['FromState']}: #{params['Body']}"

    @sender = User.find_by_phone( params['From'] )

    if @sender.nil?
      @sender = User.new(:phone => params['From'], :email => params['Body'].strip)

      if @sender.save
        render :nothing => true, :status => 200
      else
        @message = ""
        @sender.errors.each do |name, error|
          @message = @message + name.to_s + " " + error + "\n"
        end
        render :xml => {:Sms => @message }.to_xml(:root => 'Response')
      end
    else
      @message = "You have already signed up with email: #{@sender.email}, access your dashboard:  #{ApplicationController.get_hostname}#{dashboard_path(:auth_token => @sender.authentication_token)}"
      render :xml => {:Sms => @message }.to_xml(:root => 'Response')
    end
  end
end
