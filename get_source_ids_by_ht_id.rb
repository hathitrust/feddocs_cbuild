# frozen_string_literal: true

# Take a list of oclcs
# and spit out a list of HT item ids for collection building.
#
require "registry"
require "dotenv"

Dotenv.load!
SourceRecord = Registry::SourceRecord
RegistryRecord = Registry::RegistryRecord
Mongoid.load!(ENV["MONGOID_CONF"], ENV["MONGOID_ENV"])

File.open(ARGV.shift).each do |line|
  ht_id = line.chomp
  SourceRecord.where(org_code: "miaahdl",
    ht_item_ids: ht_id,
    deprecated_timestamp: {"$exists": 0}).no_timeout.each do |src|
    puts src.source_id
  end
end
