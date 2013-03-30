RSpec.configure do |config|
  set :root, File.join(File.dirname(__FILE__), '../../')
  ActionMailer::Base.delivery_method = :test
  ActionMailer::Base.view_paths = File.join(Sinatra::Application.root, 'views')
end