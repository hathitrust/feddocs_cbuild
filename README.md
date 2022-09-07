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

## get_item_lists.sh ##
This is typically run Quarterly and retrieves HT Item IDs for the appropriate collections. Dependencies include:
- `get_ht_ids_by_auth.rb` for BOIA, EPA, and CRC
- `get_ht_ids_by_series.rb` for Serial Set, Foreign Relations, and CRC
- `get_ht_ids.rb` for the Mondo collection
- The latest full hathifile in the archive directory, for TRAIL

## Updating the collections ##
Historically, I diffed the new lists with the old lists or the lists downloaded from Hathitrust. See `get_new_and_deleted.sh`
These were then fed to the `c_b_client` which uses a headless browser to add/delete items. e.g.
`bundle exec ruby lib/c_b_client.rb add <collection_id> data/<coll>_new_ht_item_ids.<date>.txt`
I tended not to delete item ids that often because Series/Authority inclusion is pretty ambiguous to begin with, except for the Mondo collection.

I had hopes of developing a more fully featured collection management infrastructure on top of this "API" and have a proper collection builder API to slot into it. Neither happened.

Moving forward these lists of item ids should be run through traditional collection building infrastructure. 

## ./data/ ##
This directory's contents are currently gitignored, but past item lists have been committed in the past. Updating this may be a good way to provide additional public access to our collection lists.
