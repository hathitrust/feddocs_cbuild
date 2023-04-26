# frozen_string_literal: true

require_relative "lib/feddocs_collections"

def base_command
  who = `whoami`.chomp
  "HT_DEV= MB_SUPERUSER=#{who} /htapps/babel/mb/scripts/batch-collection.pl -o feddocs@hathitrust.org "
end

def apply_additions(name:, id:)
  additions = File.expand_path("data/#{name}_new_ht_item_ids.txt")
  unless File.readable?(additions)
    puts "Can't read additions in #{additions}, skipping"
    return
  end
  cmd = base_command + "-a #{id} -f #{additions}"
  `#{cmd}`
end

def apply_deletions(name: collection_name, id: collection_id)
  deletions = File.expand_path("data/#{name}_deleted_ht_item_ids.txt")
  unless File.readable?(deletions)
    puts "Can't read deletions in #{deletions}, skipping"
    return
  end
  cmd = base_command + "-D #{id} -f #{deletions}"
  `#{cmd}`
end

FeddocsCollections::COLLECTIONS.each do |name, id|
  apply_additions name: name, id: id
  apply_deletions name: name, id: id
end
