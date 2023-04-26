#!/usr/bin/env bash

source "utils.sh"

zgrep "GWLA" $(ls /htapps/archive/hathifiles/hathi_full* | tail -1) | cut -f1 | sort_uniq | grep -v htitem > data/trail_ht_item_ids.txt
