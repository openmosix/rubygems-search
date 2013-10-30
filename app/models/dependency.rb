class Dependency
  include Mongoid::Document
  
  field :name, type: String
  field :requirements, type: String
  
end