config = SimpleConfig.for(:application)
Tire::Configuration.url(config.elasticsearch.url)
Tire.configure { logger "#{Rails.root}/log/elasticsearch-queries.log" } if ENV['ES_LOG']