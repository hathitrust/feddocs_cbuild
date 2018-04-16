# frozen_string_literal: true

# Take a series name and spit out a list of HT item ids for collection building.
require 'mongoid'
Mongo::Logger.logger = Logger.new('mongo.log')
Mongo::Logger.logger.level = Logger::FATAL
require 'registry'
require 'dotenv'
require 'pp'
Dotenv.load!
SourceRecord = Registry::SourceRecord
Mongoid.load!(ENV['MONGOID_CONF'], ENV['MONGOID_ENV'])

series = ARGV.shift
SourceRecord.where(
  org_code: 'miaahdl',
  series: series,
  deprecated_timestamp: { "$exists": 0 }
).no_timeout.each do |src|
  src.ht_item_ids.each { |id| puts id }
end
