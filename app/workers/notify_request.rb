class NotifyRequest
  @queue = :user

  def self.perform( user_id, notification_id )

    @user = User.find( user_id )
    @request = @user.requests.where( :id => notification_id ).first

    @message = "#{@request.provider.name } is requesting permissions to your HealthCan dashboard, you can approve it here here: #{ApplicationController.get_hostname}#{Rails.application.routes.url_helpers.requests_path(:auth_token => @user.authentication_token)}"

    TWILIO_ACCOUNT.sms.messages.create(
        :from => '+16047575181',
        :to => @user.phone,
        :body => @message
    )
  end
end