D=$(date +\%Y-\%m-\%d)
bundle exec ruby get_ht_ids_by_series.rb 'Civil Rights Commission' | sort  -T tmpsort | uniq > crc.series.tmp
bundle exec ruby get_ht_ids_by_auth.rb /l1/govdocs/authority_lists/txt/crc.auths.txt | sort -T tmpsort | uniq > crc.auth.tmp
cat crc.series.tmp crc.auth.tmp | sort -T tmpsort | uniq > /l1/govdocs/cbuild/data/crc_ht_item_ids.$D.txt
