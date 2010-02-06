ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"

begin
  require "vendor/dependencies/lib/dependencies"
rescue LoadError
  require "dependencies"
end

require "monk/glue"
require "haml"
require "sass"
require "dm-core"
require "do_sqlite3"
require "text"

class Main < Monk::Glue
  set :app_file, __FILE__
  set :port, 6060
  use Rack::Session::Cookie
end

# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

sqlite3_path = settings(:sqlite3)[:database]
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/#{sqlite3_path}")
DataMapper.auto_upgrade!

if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

Main.run! if Main.run?
