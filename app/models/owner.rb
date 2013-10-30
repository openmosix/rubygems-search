class Owner
  include Mongoid::Document
  
  field :email, type: String
  field :gittip_username, type: String
  
  embedded_in :ruby_gem
end