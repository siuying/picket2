source "https://rubygems.org"

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
gem 'sqlite3', :group => :development
gem 'pg', :group => :production

# State Machine
gem "transitions", :require => ["transitions", "active_record/transitions"]

group :development do 
  gem 'rake'
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'webmock'
end