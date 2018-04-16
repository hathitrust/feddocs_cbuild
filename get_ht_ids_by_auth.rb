# frozen_string_literal: true

# Take a list of authority links ("sameAs")
# and spit out a list of HT item ids for collection building.
require 'registry'
require 'dotenv'
require 'pp'
Dotenv.load!
Mongo::Logger.logger.level = ::Logger::FATAL
SourceRecord = Registry::SourceRecord
RegistryRecord = Registry::RegistryRecord
Mongoid.load!(ENV['MONGOID_CONF'], ENV['MONGOID_ENV'])

auth_list = ARGV.shift
File.open(auth_list).each do |line|
  auth = line.chomp
  # RegistryRecords's sources might not agree about authorities.
  # HTDL source record might not have the author, but be clustered with another
  # source that claims it matches our authority. Therefore, we should start
  # with the Registry Record and then export the associated HT item ids.
  RegistryRecord.where(source_org_codes: 'miaahdl',
                       deprecated_timestamp: { "$exists": 0 },
                       "$or": [{ author_lccns: auth },
                               { added_entry_lccns: auth }]).no_timeout
                .each do |reg|
    reg.sources.select { |s| s.org_code == 'miaahdl' }.each do |s|
      s.ht_item_ids.map { |id| puts id }
    end
  end
end
