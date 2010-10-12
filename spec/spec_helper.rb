require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

require 'spec'

ActiveRecord::Base.establish_connection(:adapter  => 'sqlite3', :database => TEST_DB)

module Spec
  class ExampleGroup
    def clear_storage
      `cat #{File.expand_path(File.dirname(__FILE__) + "/../db/schema.sql")} | sqlite3 #{TEST_DB}`
    end
  end
end
