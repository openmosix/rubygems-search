class Version
  include Mongoid::Document

  field :authors, type: String
  field :built_at, type: String
  field :description, type: String
  field :downloads_count, type: Integer
  field :number, type: String
  field :summary, type: String
  field :platform, type: String
  field :prerelease, type: Boolean
  field :licenses, type: Array  #of strings

  embedded_in :ruby_gem

end