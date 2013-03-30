require "rubygems"
require "bundler"
Bundler.require
require "sinatra/activerecord/rake"
$LOAD_PATH << "app"

require "models/settings"
require "models/site"
require "models/site_watcher"
require "sinatra/activerecord"

set :database, Settings.database_url

task :default do
  hydra = Typhoeus::Hydra.new(:max_concurrency => Settings.http.concurrency)
  sites = SiteWatcher.watch_urls(Settings.sites, Settings.http.timeout, hydra)
  sites.each do |site|
    puts "#{site.url} - #{site.state} (#{site.last_response_time})"
  end
end