require "./app"

# manage activerecord connections
# see: https://github.com/puma/puma/issues/59
use ActiveRecord::ConnectionAdapters::ConnectionManagement

run Sinatra::Application