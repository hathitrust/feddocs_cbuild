# frozen_string_literal: true

# Take a list of authority links ("sameAs")
# and spit out a list of HT item ids for collection building.
require 'mongoid'
Mongo::Logger.logger.level = ::Logger::FATAL
require 'registry'
require 'dotenv'
require 'pp'
Dotenv.load!
SourceRecord = Registry::SourceRecord
RegistryRecord = Registry::RegistryRecord
Mongoid.load!(ENV['MONGOID_CONF'], ENV['MONGOID_ENV'])

auth_list = ARGV.shift
sources_seen = []
File.open(auth_list).each do |line|
  auth = line.chomp
  # RegistryRecords's sources might not agree about authorities.
  # HTDL source record might not have the author, but be clustered with another
  # source that claims it matches our authority. Therefore, we should start
  # with the Registry Record and then export the associated HT item ids.
  RegistryRecord.where( "$or": [{ author_lccns: auth },
                               { added_entry_lccns: auth }],
                        deprecated_timestamp:{"$exists":0},
                        source_org_codes:"miaahdl").each do |reg|
    ec_digest = Digest::SHA256.hexdigest(reg.enum_chron)
    reg.sources.select { |s| s.org_code == 'miaahdl' }.each do |s|
      s.holdings.each do |k, h|
        next unless ec_digest == k
        h.map {|hfield| puts hfield['u']}
      end
    end
  end
end

# make sure we got everything from sources
File.open(auth_list).each do |line|
  auth = line.chomp
  SourceRecord.where( "$or": [{ author_lccns: auth },
                               { added_entry_lccns: auth }],
                        deprecated_timestamp:{"$exists":0},
                        org_code:"miaahdl").each do |src|
    src.marc.each_by_tag('974') do |field|
      field.subfields.each do |sf|
        next unless sf.code == 'u'
        puts sf.value
      end
    end
  end
end


