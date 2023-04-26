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

oclcs = []
File.open(ARGV.shift).each do |line|
  line.chomp!
  oclcs << line.gsub(/^0+/, "").to_i
end
SourceRecord.where(:org_code => "miaahdl",
  :oclc_resolved.in => oclcs,
  :deprecated_timestamp => {"$exists": 0}).no_timeout.each do |src|
  src.ht_item_ids.each { |id| puts id }
end
