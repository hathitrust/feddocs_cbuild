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

def apply_deletions(name:, id:)
  deleted_path = File.expand_path("data/#{name}_deleted_ht_item_ids.txt")
  current_path = File.expand_path("data/#{name}_current_ht_item_ids.txt")
  unless File.readable?(deleted_path)
    puts "Can't read deletions in #{deleted_path}, skipping"
    return
  end
  unless File.readable?(current_path)
    puts "Can't read current ids in #{current_path}, skipping"
    return
  end
  if too_many_deletions?(deleted_path: deleted_path, current_path: current_path)
    puts "#{deleted_path} has too many deleted ids, skipping"
    return
  end
  cmd = base_command + "-D #{id} -f #{deleted_path}"
  `#{cmd}`
end

# true if the number of deletions would be 10% or more of the current membership.
def too_many_deletions?(deleted_path:, current_path:)
  deleted_count = count_lines deleted_path
  current_count = count_lines current_path
  return true if current_count.zero?
  deleted_count.to_f / current_count.to_f >= 0.1
end

def count_lines(path)
  File.open(path, "r") do |file|
    file.readlines.size
  end
end

FeddocsCollections::COLLECTIONS.each do |name, id|
  apply_additions name: name, id: id
  apply_deletions name: name, id: id
end
