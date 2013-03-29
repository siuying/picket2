source "https://rubygems.org"

# Scheduler
gem 'rufus-scheduler', :require => 'rufus/scheduler'

# Config files
gem 'settingslogic'

# Framework
gem 'sinatra'
gem 'sinatra-activerecord', :require => "sinatra/activerecord"
gem 'puma'

# HTTP
gem "typhoeus"

# Database

platforms :jruby do
  gem 'jruby-openssl'
  gem 'activerecord-jdbcsqlite3-adapter'
end

platforms :ruby do
  gem 'sqlite3', :group => :development
  gem 'pg', :group => :production
end

# State Machine
gem "transitions", :require => ["transitions", "active_record/transitions"]

group :development do 
  gem 'rake'
end