require "rubygems"
require "bundler"
Bundler.require
require "sinatra/activerecord/rake"
$LOAD_PATH << "app"

require "models/settings"
require "models/site"
require "jobs/site_checker"
require "sinatra/activerecord"

set :database, Settings.database_url

task :default do
  sites = SiteChecker.check_urls(Settings.sites)
  sites.each do |site|
    puts "#{site.url} - #{site.state}"
  end
end