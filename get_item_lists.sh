D=$(date +\%Y-\%m-\%d)

# BOIA: 271744772
bundle exec ruby get_ht_ids_by_auth.rb /l1/govdocs/authority_lists/txt/boia.auths.txt\
  | sort -T tmpsort | uniq > data/boia_ht_item_ids.$D.txt 
# comm -2 -3 data/boia_ht_item_ids.$D.txt data/boia_current_ht_item_ids.$D.txt\
#  > data/boia_new_ht_item_ids.$D.txt
# comm -1 -3 data/boia_ht_item_ids.$D.txt data/boia_current_ht_item_ids.$D.txt\
#  > data/boia_deleted_ht_item_ids.$D.txt
 
# FRUS: 155520420
bundle exec ruby get_ht_ids_by_series.rb 'Foreign Relations' | sort  -T tmpsort | uniq | grep -v htitem\
  > data/frus_ht_item_ids.$D.txt
# comm -2 -3 data/frus_ht_item_ids.$D.txt data/frus_current_ht_item_ids.$D.txt\
#  > data/frus_new_ht_item_ids.$D.txt
# comm -1 -3 data/frus_ht_item_ids.$D.txt data/frus_current_ht_item_ids.$D.txt\
#  > data/frus_deleted_ht_item_ids.$D.txt
 
 
# # EPA: 659388570 
bundle exec ruby get_ht_ids_by_auth.rb /l1/govdocs/authority_lists/txt/epa.auths.txt\
  | sort  -T tmpsort | uniq > data/epa_ht_item_ids.$D.txt
# comm -2 -3 data/epa_ht_item_ids.$D.txt data/epa_current_ht_item_ids.$D.txt\
#  > data/epa_new_ht_item_ids.$D.txt
# comm -1 -3 data/epa_ht_item_ids.$D.txt data/epa_current_ht_item_ids.$D.txt\
#  > data/epa_deleted_ht_item_ids.$D.txt


# CRC: 1491645774
bash get_crc_item_ids.sh
#bundle exec ruby get_ht_ids_by_series.rb 'Civil Rights Commission' | sort | uniq | grep -v htitem\
#  > data/crc_ht_item_ids.$D.txt
# comm -2 -3 data/crc_ht_item_ids.$D.txt data/crc_current_ht_item_ids.$D.txt\
#  > data/crc_new_ht_item_ids.$D.txt
# comm -1 -3 data/crc_ht_item_ids.$D.txt data/crc_current_ht_item_ids.$D.txt\
#  > data/crc_deleted_ht_item_ids.$D.txt


# All: 2062901859
bundle exec ruby get_ht_ids.rb | sort  -T tmpsort | uniq > data/all_ht_item_ids.$D.txt
# comm -2 -3 data/all_ht_item_ids.$D.txt data/all_current_ht_item_ids.$D.txt\
#  > data/all_new_ht_item_ids.$D.txt
# comm -1 -3 data/all_ht_item_ids.$D.txt data/all_current_ht_item_ids.$D.txt\
#  > data/all_deleted_ht_item_ids.$D.txt

# Serial Set: 148631352
bundle exec ruby get_ht_ids_by_series.rb 'Congressional Serial Set' | sort -T tmpsort  | uniq | grep -v htitem\
  > data/serial_set_ht_item_ids.$D.txt
# comm -2 -3 data/serial_set_ht_item_ids.$D.txt data/serial_set_current_ht_item_ids.$D.txt\
#  > data/serial_set_new_ht_item_ids.$D.txt
# comm -1 -3 data/serial_set_ht_item_ids.$D.txt data/serial_set_current_ht_item_ids.$D.txt\
#  > data/serial_set_deleted_ht_item_ids.$D.txt

# TRAIL
bash get_trail_item_ids.sh
