require 'sequel'
connection_string = 'postgres://localhost/tribator'
DB = Sequel.connect(ENV["DATABASE_URL"] || connection_string)

require_relative 'lib/task'
require_relative 'lib/answer'
require_relative 'app'

run Tribator