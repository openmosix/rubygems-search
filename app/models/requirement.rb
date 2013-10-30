class Requirement
  include Mongoid::Document
    
  embeds_many :development, store_as: 'development', class_name:'Dependency'
  embeds_many :runtime, store_as: 'runtime', class_name:'Dependency'
  embedded_in :ruby_gem
  
end