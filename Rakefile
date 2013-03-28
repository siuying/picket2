require "rubygems"
require "bundler"
Bundler.require

$LOAD_PATH << "app"

require "models/settings"
require "models/site"
require "jobs/site_checker"

set :database, Settings.database_url

task :default do
  sites = SiteChecker.check_urls(Settings.sites)
  sites.each do |site|
    puts "#{site.url} - #{site.state}"
  end
end