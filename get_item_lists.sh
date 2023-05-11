#!/usr/bin/env bash

source "utils.sh"
set -euo pipefail

# BOIA: 271744772
bundle exec ruby get_ht_ids_by_auth.rb /l1/govdocs/authority_lists/txt/boia.auths.txt\
    | sort_uniq > data/boia_ht_item_ids.txt || {
    echo "Failed to extract BOIA id list"
    exit 1
}

# FRUS: 155520420
bundle exec ruby get_ht_ids_by_series.rb 'Foreign Relations' | sort_uniq | grep -v htitem\
  > data/frus_ht_item_ids.txt || {
    echo "Failed to extract FRUS id list"
    exit 1
}
 
# # EPA: 659388570 
bundle exec ruby get_ht_ids_by_auth.rb /l1/govdocs/authority_lists/txt/epa.auths.txt\
  | sort_uniq > data/epa_ht_item_ids.txt || {
    echo "Failed to extract EPA id list"
    exit 1
}

# CRC: 1491645774
bash get_crc_item_ids.sh || {
    echo "Failed to extract CRC id list"
    exit 1
}

# All: 2062901859
bundle exec ruby get_ht_ids.rb | sort_uniq > data/all_ht_item_ids.txt || {
    echo "Failed to extract full id list"
    exit 1
}

# Serial Set: 148631352
bundle exec ruby get_ht_ids_by_series.rb 'Congressional Serial Set' | sort_uniq | grep -v htitem\
  > data/serial_set_ht_item_ids.txt || {
    echo "Failed to extract Serial Set id list"
    exit 1
}

# TRAIL
bash get_trail_item_ids.sh || {
    echo "Failed to extract TRAIL id list"
    exit 1
}
