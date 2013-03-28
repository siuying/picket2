class Settings < Settingslogic
  source "#{File.dirname(__FILE__)}/../../config/application.yml"
  namespace ENV["RACK_ENV"] || "development"
  load!
end