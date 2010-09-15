require 'rubygems'
require "bundler/setup"

require 'active_record'
require 'curb'
require 'yaml'

require 'models'

ActiveRecord::Base.establish_connection(:adapter  => 'sqlite3', :database => 'production_db')