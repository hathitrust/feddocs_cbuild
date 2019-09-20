D=$(date +\%Y-\%m-\%d)

# BOIA: 271744772
comm -2 -3 data/boia_ht_item_ids.$D.txt data/boia_current_ht_item_ids.$D.txt\
  > data/boia_new_ht_item_ids.$D.txt
comm -1 -3 data/boia_ht_item_ids.$D.txt data/boia_current_ht_item_ids.$D.txt\
  > data/boia_deleted_ht_item_ids.$D.txt
 
# FRUS: 155520420
comm -2 -3 data/frus_ht_item_ids.$D.txt data/frus_current_ht_item_ids.$D.txt\
 > data/frus_new_ht_item_ids.$D.txt
comm -1 -3 data/frus_ht_item_ids.$D.txt data/frus_current_ht_item_ids.$D.txt\
 > data/frus_deleted_ht_item_ids.$D.txt
 
# EPA: 659388570 
comm -2 -3 data/epa_ht_item_ids.$D.txt data/epa_current_ht_item_ids.$D.txt\
 > data/epa_new_ht_item_ids.$D.txt
comm -1 -3 data/epa_ht_item_ids.$D.txt data/epa_current_ht_item_ids.$D.txt\
 > data/epa_deleted_ht_item_ids.$D.txt

# CRC: 1491645774
comm -2 -3 data/crc_ht_item_ids.$D.txt data/crc_current_ht_item_ids.$D.txt\
 > data/crc_new_ht_item_ids.$D.txt
comm -1 -3 data/crc_ht_item_ids.$D.txt data/crc_current_ht_item_ids.$D.txt\
 > data/crc_deleted_ht_item_ids.$D.txt

# TRAIL: 1100951433
comm -2 -3 data/trail_ht_item_ids.$D.txt data/trail_current_ht_item_ids.$D.txt\
 > data/trail_new_ht_item_ids.$D.txt
comm -1 -3 data/trail_ht_item_ids.$D.txt data/trail_current_ht_item_ids.$D.txt\
 > data/trail_deleted_ht_item_ids.$D.txt

# All: 2062901859
comm -2 -3 data/all_ht_item_ids.$D.txt data/all_current_ht_item_ids.$D.txt\
 > data/all_new_ht_item_ids.$D.txt
comm -1 -3 data/all_ht_item_ids.$D.txt data/all_current_ht_item_ids.$D.txt\
 > data/all_deleted_ht_item_ids.$D.txt

# Serial Set: 148631352
comm -2 -3 data/serial_set_ht_item_ids.$D.txt data/serial_set_current_ht_item_ids.$D.txt\
 > data/serial_set_new_ht_item_ids.$D.txt
comm -1 -3 data/serial_set_ht_item_ids.$D.txt data/serial_set_current_ht_item_ids.$D.txt\
 > data/serial_set_deleted_ht_item_ids.$D.txt


