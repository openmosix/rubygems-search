class RubyGem
  include Mongoid::Document
  
  store_in collection: "gems"
  
  field :name, type: String
  field :downloads, type: Integer
  field :version, type: String
  field :version_downloads, type: Integer
  field :platform, type: String
  field :authors, type: String
  field :info, type: String
  field :licenses, type: Array #of strings
  field :project_uri, type: String
  field :gem_uri, type: String
  field :homepage_uri, type: String
  field :wiki_uri, type: String
  field :documentation_uri, type: String
  field :mailing_list_uri, type: String
  field :source_code_uri, type: String
  field :bug_tracker_uri, type: String
  
  embeds_one :dependencies, store_as: 'dependencies', class_name: 'Requirement'
# field :versions 
  embeds_many :versions
  embeds_many :owners
  
  index({ name: 1 }, { unique: true, background: true })
  
end