# frozen_string_literal: true

# Take a list of catalog ids (Zephir Ids)
# and spit out a list of HT item ids for collection building.
#
require "registry"
require "dotenv"
Dotenv.load!
SourceRecord = Registry::SourceRecord
RegistryRecord = Registry::RegistryRecord
Mongoid.load!(ENV["MONGOID_CONF"], ENV["MONGOID_ENV"])

id_list = ARGV.shift
File.open(id_list).each do |line|
  local_id = line.chomp
  local_id.gsub!(/^0+/, "")
  SourceRecord.where(org_code: "miaahdl",
    local_id: local_id).no_timeout.each do |src|
    src.ht_item_ids.each { |id| puts id }
  end
end
