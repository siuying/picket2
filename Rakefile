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
  sites = SiteChecker.check_urls(Settings.sites, Settings.http.timeout, Settings.http.concurrency)
  sites.each do |site|
    puts "#{site.url} - #{site.state} (#{site.last_response_time})"
  end
end