#!/usr/bin/env bash

source "utils.sh"
bundle exec ruby get_ht_ids_by_series.rb 'Civil Rights Commission' | sort_uniq > crc.series.tmp
bundle exec ruby get_ht_ids_by_auth.rb /l1/govdocs/authority_lists/txt/crc.auths.txt | sort_uniq > crc.auth.tmp
cat crc.series.tmp crc.auth.tmp | sort_uniq > data/crc_ht_item_ids.txt
