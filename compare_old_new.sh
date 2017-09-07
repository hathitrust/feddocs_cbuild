#lines in new file not in old 
comm -2 -3 <new list> <old list>

#lines in old file not in new
comm -1 -3 <new list> <old list>
