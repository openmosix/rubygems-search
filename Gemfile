source 'https://rubygems.org'
ruby '1.9.3'

# Rails 4
gem 'rails', '4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'sass-rails',   '~> 4.0.0'
gem 'activeresource', :github=> 'rails/activeresource'
gem 'jquery-rails'
gem 'haml-rails'
gem 'dalli' #memcache
gem "multi_json", "~> 1.7.9"

# Bootstrap and UIs
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails',
                            :github => 'anjlab/bootstrap-rails',
                            :branch => '3.0.0'
gem 'kaminari'
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem "font-awesome-rails"

# Javascript
gem 'uglifier', '>= 1.0.3'

# Mongo
gem 'mongoid', :git => 'git://github.com/mongoid/mongoid.git'

# Configurations
gem 'simpleconfig', '~> 1.1.3', :require => 'simple_config'
gem 'figaro'

gem 'unicorn'
gem 'tire'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'html2haml'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'

end
group :production do
  gem 'thin'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', "~> 1.4.0", :require=>false
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'launchy'
end
