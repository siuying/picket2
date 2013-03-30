require "rubygems"
require "bundler"
Bundler.require

$LOAD_PATH << "app"

require "helpers/sites_helper"
require "models/site_watcher"
require "models/settings"

set :database, Settings.database_url
set :public_folder, File.dirname(__FILE__) + '/public'
helpers SitesHelper

configure do
  @scheduler = Rufus::Scheduler.start_new
  @scheduler.every(Settings.interval) do
    hydra = Typhoeus::Hydra.new(:max_concurrency => Settings.http.concurrency)
    sites = SiteWatcher.watch_urls(Settings.sites, Settings.http.timeout, hydra)
    sites.each do |site|
      puts "#{site.url} - #{site.state} (#{site.last_response_time})"
    end
  end

  # Email setup
  if production?
    ActionMailer::Base.smtp_settings = {
      :address => "smtp.sendgrid.net",
      :port => '25',
      :authentication => :plain,
      :user_name => Settings.email.username,
      :password => Settings.email.password,
      :domain => Settings.email.domain
    }
    ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')
  else
    ActionMailer::Base.delivery_method = :file
    ActionMailer::Base.file_settings = { :location => File.join(Sinatra::Application.root, 'tmp/emails') }
    ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')
  end
end

get "/" do
  @sites = Site.order(:url).all
  puts "#{@sites.size} sites"
  erb :index
end