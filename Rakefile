require "rubygems"
require "bundler"
Bundler.require

$LOAD_PATH << "app"

require "models/settings"
require "models/site"
require "jobs/site_checker"

set :database, Settings.database_url

task :default do
  Settings.sites.each do |url|
    SiteChecker.perform(url)
  end
end