require 'rubygems'
require "bundler/setup"

require 'active_record'
require 'curb'
require 'yaml'

Dir[File.dirname(__FILE__) + '/../app/models/*.rb'].each do |file| 
  require file
end

PRODUCTION_DB = File.expand_path(File.dirname(__FILE__) + "/../db/production.sqlite3")
TEST_DB = File.expand_path(File.dirname(__FILE__) + "/../db/test.sqlite3")

ActiveRecord::Base.establish_connection(:adapter  => 'sqlite3', :database => PRODUCTION_DB)