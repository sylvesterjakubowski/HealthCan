class Provider
  include Mongoid::Document

  has_many :appointments

  field :name
  field :phone

  validates_uniqueness_of :phone

end