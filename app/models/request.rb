class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
  belongs_to :provider

end