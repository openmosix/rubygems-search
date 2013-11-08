rubygems-search
===============

A simple Rails interface to search through RubyGems data. Proof of concept for RubyConf 2013

A running example is deployed [here](http://rubyconf.bonmassar.it) - it will be down after RubyConf. Be nice - it's a small instance running ES/Mongo/Rails - don't break it :)
 
## Install

Download the repo && run bundle install.

You need to have MongoDB running on localhost (port 27017) and ElasticSearch (port 9200).
The app will try to connect on MongoDB, db=rubygems and collection=gems

## Data

The project comes with no data. You need to populate your MongoDB using the RubyGems Crawler running on your local machine [available here](https://github.com/openmosix/rubygems-crawler/) or by downloading an existing MongoDB dump  [available here](https://github.com/openmosix/rubygems-crawler/blob/master/downloads/mongo_dump.tbz2)

You can test your data is properly loaded using the mongo console:

    $ mongo localhost:27017/rubygems
    MongoDB shell version: 2.2.0
    connecting to: localhost:27017/rubygems
    > db.gems.count()
    64741
    >

## Add MongoDB Indexes

This application defines a few indexes to navigate through MongoDB results. You need to install a few indexes and you can do that by running the following command:

   $ rake db:mongoid:create_indexes RAILS_ENV=development
   I, [2013-11-08T08:08:38.704069 #18230]  INFO -- : MONGOID: Created indexes on RubyGem:
   I, [2013-11-08T08:08:38.704215 #18230]  INFO -- : MONGOID: Index: {:name=>1}, Options: {:unique=>true, :background=>true, :dropDups=>true}
   
## Run the application

  $ rails s
  
and connect to http://localhost:3000/

## Search from command line

You can execute searches using Rails command line ('rails c'). The RubyGem class support 2 search methods: 

  RubyGem.simple_search(search_terms, options={})
  RubyGem.advanced_search(search_conditions, options={})
  
The available options are:

  :page Defines the results page number (for pagination)
  :per  Defines the results page size (number of results per page)
  :facets (True/False) Include facets in search results
  
To use the 'simple_search', just pass a search string to the 'search_terms'. For example:

  > RubyGem.simple_search('twitter AND bootstrap NOT rails', page: 2, per: 10).results
  
To use the 'advanced_search' pass an hash of search terms to the 'search_conditions'. The available keys are:

  :name, :info, :owners, :authors, :licenses, :version, :runtime_dependencies, :dev_dependencies
  
For example:

  > RubyGem.advanced_search({runtime_dependencies: 'tor'}, facets:true).results