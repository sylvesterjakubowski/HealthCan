class TwilioController < ApplicationController

  #test number for tunnel is 604-210-6329
  #SmsSid	A 34 character unique identifier for the message. May be used to later retrieve this message from the REST API.
  #AccountSid	The 34 character id of the Account this message is associated with.
  #From	The phone number that sent this message.
  #To	The phone number of the recipient.
  #Body	The text body of the SMS message. Up to 160 characters long.
  #http://www.twilio.com/docs/api/twiml/sms/twilio_request
  def twilio_text
    logger.info "SMS REQUEST FROM  #{params['From']} to #{params["To"]} in #{params['FromCity']}, #{params['FromState']}: #{params['Body']}"

    @receiver = User.find_by_phone( params['To'] )

    if @receiver.nil?
      notify_airbrake( Exception.new( "Got Text for non-existent number") )
      render :xml => {:Sms => "Error" }.to_xml(:root => 'Response')
      return
    end

    @sender = User.find_by_phone( params['From'] )
    @product = Product.find_by_user_and_code( @receiver, params["Body"].strip )

    begin
      if @sender && @product
        #bill the customer for purchase

        if !@sender.chargeable?
          @message = "You need to put your credit card information in before we can process this order"
        else
          @purchase = Purchase.create!( :user => @sender, :product => @product, :store=> @receiver, :billed => false, :completed => true )
          @message = "Please enjoy your #{@product.title}"
        end
      elsif @sender.nil? && @product.nil?
        #product wasn't correct, but try and signup user
        @sender = User.create_guest( params['From'] )
        @message = "You specifed an invalid product, but you can still register by clicking on "
      elsif @sender && @product.nil?
        #invlalid response
        @message = "That was not a valid entry, "

      else
        #product good, but sender not, try and signup with existing thing
        @sender = User.create( :phone => params['From'] )
        if @sender.purchases.count == 1
          #send a memo saying we need a credit card to bill your first purchase before completing another
          @message = "Before we process this order, we "
        else
          @purchase = Purchase.create( :user => @sender, :store=> @receiver, :product => @product, :billed => false, :completed => false )
        end
      end
    rescue Exception => e
      notify_airbrake( e )
      @message = "An Error occurred; administrators have been notified; you were not billed; please try again"
      throw e
    end


    render :xml => {:Sms => @message }.to_xml(:root => 'Response')
  end
end
