require 'twilio-ruby'


# put your own credentials here

# set up a client to talk to the Twilio REST API
@twilio_client = Twilio::REST::Client.new APP_CONFIG['twilio_sid'], APP_CONFIG['twilio_token']
@twilio_account = @twilio_client.account
