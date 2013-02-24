class DemoAuthRequest
  @queue = :user

  def self.perform( user_id )
    user = User.find( user_id )
    provider = Provider.all[2]
    user.requests.create(:provider => provider)
  end

end