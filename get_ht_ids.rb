# frozen_string_literal: true

require "mongoid"
Mongo::Logger.logger = Logger.new("mongo.log")
Mongo::Logger.logger.level = Logger::FATAL
require "registry/registry_record"
require "registry/source_record"

SourceRecord = Registry::SourceRecord

# connect Mongoid
Mongoid.load!(ENV["MONGOID_CONF"], ENV["MONGOID_ENV"])

SourceRecord.where(org_code: "miaahdl",
  in_registry: true,
  deprecated_timestamp: {"$exists": 0}).no_timeout.each do |s|
  s.ht_item_ids.each { |id| puts id }
end
