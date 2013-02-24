class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
  belongs_to :provider
  belongs_to :user

  after_create :notify_user

  def notify_user
    unless Rails.env.test?
      Resque.enqueue( NotifyRequest, self.user.id, self.id )
    end
  end

end