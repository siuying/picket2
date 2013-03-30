require "rubygems"
require "bundler"
Bundler.require :default, :test, :development

$LOAD_PATH << "app"
require "pry"

require 'support/activemailer'
require 'webmock/rspec'
require 'models/settings'

RSpec.configure do |config|
  set :database, Settings.database_url
  set :root, File.join(File.dirname(__FILE__), '..')
end