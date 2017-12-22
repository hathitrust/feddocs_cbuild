# Take a list of authority links ("sameAs")
# and spit out a list of HT item ids for collection building.
#
require 'registry'
require 'dotenv'
require 'pp'
Dotenv.load!
SourceRecord = Registry::SourceRecord
RegistryRecord = Registry::RegistryRecord
Mongoid.load!(File.expand_path("../config/mongoid.yml", __FILE__), :production)

auth_list = ARGV.shift
num_according_to_regrecs = 0
open(auth_list).each do | line | 
  auth = line.chomp
  # RegistryRecords might not agree about authorities.
  RegistryRecord.where(source_org_codes:"miaahdl",
                       deprecated_timestamp:{"$exists":0},
                       "$or":[{author_lccns:auth},{added_entry_lccns:auth}]).no_timeout.each do | reg |
    ht_ids = (reg.ht_ids_lv + reg.ht_ids_fv).uniq
    ht_ids.each do | local_id |
      local_id.gsub!(/^0+/, '')
      SourceRecord.where(org_code:"miaahdl", 
                         local_id:local_id).no_timeout.each do | src |
        num_according_to_regrecs += src.ht_item_ids.count
        als = src.author_lccns
        src.save
      end
    end
  end
  SourceRecord.where(org_code:"miaahdl",
                     deprecated_timestamp:{"$exists":0},
                     "$or":[{author_lccns:auth},{added_entry_lccns:auth}]).no_timeout.each do |src|
    src.ht_item_ids.each {|id| puts id}
  end
end

puts "num according to regrecs: #{num_according_to_regrecs}"
