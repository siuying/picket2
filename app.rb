require "rubygems"
require "bundler"
Bundler.require

$LOAD_PATH << "app"

require "helpers/sites_helper"
require "models/settings"
require "models/site"
require "jobs/site_checker"

set :database, Settings.database_url
set :public_folder, File.dirname(__FILE__) + '/public'
helpers SitesHelper

configure do
  @scheduler = Rufus::Scheduler.start_new
  @scheduler.every(Settings.interval) do
    Settings.sites.each do |url|
      site = SiteChecker.perform(url)
      puts "#{site.url} - #{site.state}"
    end
  end
end

get "/" do
  @sites = Site.all
  puts "#{@sites.size} sites"
  erb :index
end