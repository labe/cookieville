require 'pathname'
require 'sqlite3'
require 'active_record'
require 'logger'
require_relative '../app/models/baker'
require_relative '../app/models/cookie'
require_relative '../app/models/oven'
require_relative '../app/models/status'
require_relative '../app/models/recipe'
require_relative '../app/controllers/player'
require_relative '../app/viewers/viewer'

APP_ROOT = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..')))

APP_NAME = APP_ROOT.basename.to_s

DB_PATH  = APP_ROOT.join('db', APP_NAME + ".db").to_s

if ENV['DEBUG']
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

# Automatically load every file in APP_ROOT/app/models/*.rb, e.g.,
#   autoload "Person", 'app/models/person.rb'
#
# See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html

Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        # :database => DB_PATH
                                        :database => "#{File.dirname(__FILE__)}/../db/bakery.sqlite3"