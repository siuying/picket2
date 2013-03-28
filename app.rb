require "rubygems"
require "bundler"
Bundler.require

$LOAD_PATH << "app"

require "models/settings"
require "models/site"
require "jobs/site_checker"

set :database, Settings.database_url

configure do
  # @scheduler = Rufus::Scheduler.start_new
  # @scheduler.every('20s') do
  #   puts "#{Time.now} hello world"
  # end
end

get "/" do
  "Hello"
end