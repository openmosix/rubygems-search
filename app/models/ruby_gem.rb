class RubyGem
  include Mongoid::Document
  
  #### Mongo
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
  embeds_many :versions
  embeds_many :owners
  
  index({ name: 1 }, { unique: true, background: true, drop_dups: true })
  
  #### Elastic Search
  include Tire::Model::Search
  include Tire::Model::Callbacks
  
  DEFAULT_SEARCH_SIZE = 25
  
  mapping do
    indexes :id,            index: :not_analyzed
    indexes :name,          type: 'string'
    indexes :original_name, type: 'string', index: :not_analyzed
    indexes :info,          type: 'string'
    indexes :licenses,      type: 'string'  ####
    
    indexes :owners,        type: 'string'
    indexes :authors,       type: 'string'
    indexes :downloads,     type: 'integer'
    
    indexes :runtime_dependencies,  type: 'string' ####
    indexes :dev_dependencies,      type: 'string'
    
    indexes :version,         type: 'string', index: :not_analyzed
    indexes :versions,      type: 'nested', :properties => { 
                                built_at: { :type => 'date' }, 
                                number: { :type => 'string' },
                                description: { type: 'string' },
                                summary: { type: 'string' }
                            }
  end
  
  def to_indexed_json
    { id: id.to_s, 
      name: name, 
      original_name: name,
      info: info, 
      licenses: licenses, 
      downloads: downloads, 
      authors: authors.try(:split, ','), 
      owners:  owners ? owners.map{|o| o.email} : [],
      runtime_dependencies: dependencies && dependencies.runtime ? dependencies.runtime.map{|e| e.name} : [],
      dev_dependencies: dependencies && dependencies.development ? dependencies.development.map{|e| e.name} : [],
      version: version,
      versions: versions ? versions.map{|v| v.to_indexed} : []
    }.to_json
  end
  
  def self.simple_search(search_terms, options={})
    search = Tire.search RubyGem.tire.index.name, load:false do
      # What we're looking for
      query do
        string search_terms, fields: [:name, :info, :owners, :authors]
      end
      
      highlight :name, :info, :owners, :authors
      
      # Sort results
      sort { by :original_name }
      
      # Results pagination / number of results per page
      page = (options[:page] || 1).to_i
      search_size = options[:per] || DEFAULT_SEARCH_SIZE
      from (page -1) * search_size
      size search_size
      
      # Enable some facets
      if options[:facets]
        facet('global-licenses', :global => true) { terms :licenses, size: 6 }
        facet('current-licenses') { terms :licenses, size: 6 }
        facet('current-versions') { terms :version, size: 6 }
        facet('current-built_at', nested: 'versions') { date 'built_at', interval: 'month'}
      end
    end
  end
  
  def self.advanced_search(search_conditions, options={})
    fields = [:name, :info, :owners, :authors, :licenses, :version, :runtime_dependencies, :dev_dependencies]
    
    search = Tire.search RubyGem.tire.index.name, load:false do
      
      # What we're looking for
      query do
        boolean do
          fields.each do |field|
            must { string search_conditions[field], :default_operator => 'AND', :fields => [field] } if search_conditions[field].present?
          end
        end
      end
      
      highlight *fields
      
      # Sort results
      sort { by :original_name }
      
      # Results pagination / number of results per page
      page = (options[:page] || 1).to_i
      search_size = options[:per] || DEFAULT_SEARCH_SIZE
      from (page -1) * search_size
      size search_size
      
      # Enable some facets
      if search_conditions['facets']
        facet('global-licenses', :global => true) { terms :licenses, size: 6 }
        facet('current-licenses') { terms :licenses, size: 6 }
        facet('current-versions') { terms :version, size: 6 }
        facet('current-built_at', nested: 'versions') { date 'built_at', interval: 'month'}
      end
      
    end
  end
  
end