D=$(date +\%Y-\%m-\%d)
zgrep "GWLA" $(ls /htapps/archive/hathifiles/hathi_full* | tail -1) | cut -f1 | sort -T tmpsort | uniq | grep -v htitem > data/trail_ht_item_ids.$D.txt
