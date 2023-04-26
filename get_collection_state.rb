# frozen_string_literal: true

require_relative "lib/feddocs_collections"

def execute_command(cmd)
  `#{cmd}`
  unless $?.success?
    puts "#{cmd} failed, exiting"
    exit 1
  end
end

FeddocsCollections::COLLECTIONS.each do |name, id|
  id_list = "data/#{name}_ht_item_ids.txt"
  current_ids = "data/#{name}_current_ht_item_ids.txt"
  new_ids = "data/#{name}_new_ht_item_ids.txt"
  deleted_ids = "data/#{name}_deleted_ht_item_ids.txt"
  cmd = "HT_DEV= BATCH_COLLECTION_USER=hathitrust@gmail.com" +
    " /htapps/babel/mb/scripts/batch-collection.pl -M #{id}" +
    " 2>&1 >/dev/null | sort -T tmpsort | uniq > #{current_ids}"
  execute_command cmd
  cmd = "comm -2 -3 #{id_list} #{current_ids} > #{new_ids}"
  execute_command cmd
  cmd = "comm -1 -3 #{id_list} #{current_ids} > #{deleted_ids}"
  execute_command cmd
end
