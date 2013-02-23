require 'twilio-ruby'


# put your own credentials here

# set up a client to talk to the Twilio REST API
TWILIO_CLIENT= Twilio::REST::Client.new APP_CONFIG['twilio_sid'], APP_CONFIG['twilio_token']
TWILIO_ACCOUNT = TWILIO_CLIENT.account
