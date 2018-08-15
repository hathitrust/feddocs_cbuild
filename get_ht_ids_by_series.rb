# frozen_string_literal: true

# Take a series name and spit out a list of HT item ids for collection building.
require 'mongoid'
Mongo::Logger.logger = Logger.new('mongo.log')
Mongo::Logger.logger.level = Logger::FATAL
require 'registry'
require 'dotenv'
require 'pp'
Dotenv.load!
RR = Registry::RegistryRecord
Mongoid.load!(ENV['MONGOID_CONF'], ENV['MONGOID_ENV'])

series = ARGV.shift
RR.where(
  series: series,
  deprecated_timestamp: { "$exists": 0 },
  source_org_codes: 'miaahdl'
).no_timeout.each do |reg|
  reg.sources.each do |src|
    next unless src.org_code == 'miaahdl'
    src.ht_item_ids.each { |id| puts id }
  end
end
