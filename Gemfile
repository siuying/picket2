source "https://rubygems.org"

ruby "1.9.3", :engine => "jruby", :engine_version => "1.7.3"

# Scheduler
gem 'rufus-scheduler', :require => 'rufus/scheduler'

# Config files
gem 'settingslogic'

# Framework
gem 'sinatra'
gem 'rack', "~> 1.4.0"
gem 'activerecord', "~> 3.2.0"
gem 'sinatra-activerecord', :require => "sinatra/activerecord"
gem 'puma'

# Outgoing Email
gem 'actionmailer', "~> 3.2.0", :require => "action_mailer"
gem 'sendgrid'

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