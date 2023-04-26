# CBuild

Bash and ruby for updating collections managed by the feddocs@hathitrust.org user. These include:
- [U.S. Federal Documents (aka Mondo)](https://babel.hathitrust.org/cgi/mb?a=listis;c=2062901859)
- [Bureau of Indian Affairs](https://babel.hathitrust.org/cgi/mb?a=listis;c=271744772)
- [Foreign Relations of the United States](https://babel.hathitrust.org/cgi/mb?a=listis;c=155520420)
- [TRAIL: Technical Report Archive and Image Library](https://babel.hathitrust.org/cgi/mb?a=listis;c=1100951433)
- [U.S. Civil Rights Commission](https://babel.hathitrust.org/cgi/mb?a=listis;c=1491645774)
- [Congressional Serial Set](https://babel.hathitrust.org/cgi/mb?a=listis;c=148631352)
- [Environmental Protection Agency](https://babel.hathitrust.org/cgi/mb?a=listis;c=659388570)

The following collections are also owned by that user, but are static or manually managed.
- [Never a Dull Moment](https://babel.hathitrust.org/cgi/mb?a=listis;c=1484317537)
- [Statistical Abstract of the United States](https://babel.hathitrust.org/cgi/mb?a=listis;c=417723205)
- [U.S. Census of Population: 1950](https://babel.hathitrust.org/cgi/mb?a=listis;c=1986287266)
- [United States Decennial Census, 1790-1930](https://babel.hathitrust.org/cgi/mb?a=listis;c=1155585587)

## process_collections.rb
This is the top-level script that runs all of the below in the correct order.
Should be run monthly or quarterly from a cron job.

### get_item_lists.sh
Retrieves HT Item IDs for the appropriate collections. Dependencies include:
- `get_ht_ids_by_auth.rb` for BOIA, EPA, and CRC
- `get_ht_ids_by_series.rb` for Serial Set, Foreign Relations, and CRC
- `get_ht_ids.rb` for the Mondo collection
- The latest full hathifile in the archive directory, for TRAIL

Output: data/*collection*_ht_item_ids.txt

### get_collection_state.rb

Retrieves the list of current HTIDs in each collection and then
diffs each against the item lists generated above, in order to
produce lists of additions and deletions.

Output:
- data/*collection*_current_ht_item_ids.txt
- data/*collection*_new_ht_item_ids.txt
- data/*collection*_deleted_ht_item_ids.txt

### update_collections.rb

Calls `/htapps/babel/mb/scripts/batch-collection.pl` with the `-a` and `-D` flags to process adds and deletes,
respectively, for each of the collections.

## ./data/
Derived data is gitignored; there should be no compelling reason to archive or commit monthly or quarterly HTID lists.
