# frozen_string_literal: true

COMMANDS = [
  # Create data/<collection>_ht_item_ids.txt
  "./get_item_lists.sh",
  # Create data/<collection>_current_ht_item_ids.txt,
  # data/<collection>_new_ht_item_ids.txt,
  # and data/<collection>_deleted_ht_item_ids.txt
  "bundle exec ruby get_collection_state.rb",
  # Apply additions and deletions to collections
  "bundle exec ruby update_collections.rb"
]

COMMANDS.each do |cmd|
  `#{cmd}`
  unless $?.success?
    puts "#{cmd} failed"
    exit 1
  end
end
