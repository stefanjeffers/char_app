# Process for assigning correct pinname_ids and formula_ids to link table:

# 1. (Not needed?) Create a "link list" (in seed form? ) using generate_ord_values.rb
#	This one has the ord values but not the id values.
# 2. Get a superset version of this by doing the join on pinnames and formulas.
#	This one has the id values but also has extra records which should not be connected.
# 3. Format that into the seeds.rb form (Omit?) using convert_link_join_to_seeds_form.sh
#       Should merge these two steps (3 and 4).
# 4. Reformat this into an SQL update list. Need to swap order of fields, using split/join.
# 5. Feed this to sqlite3, then save (output) link table so we don't need to repeat this every time we reset db.
#
#________________________________________________________

  # But this will give a superset of the ones we want:
  # Will then need to match them up against the proto_link_seeds.rb version,
  #    and delete if equiv is not found there.

select pinnames.graph_id, pinnames.id, pinnames.ord, formulas.graph_id, formulas.id, formulas.ord
    from pinnames join formulas
       on pinnames.graph_id=formulas.graph_id
    where pinnames.base = '002';

sqlite3 dev*3 'select pinnames.graph_id, pinnames.id, pinnames.ord, formulas.id, formulas.ord \
		from pinnames join formulas on pinnames.graph_id=formulas.graph_id ;' > proto_link_join.txt

#________________________________________________________

# graph_id	id	ord	graph_id	id	ord
# 001.001.0	1	1	001.001.0	1	1
# Link.create( :graph_id => '001.001.0', :pinname_id => '0', :pinname_ord => '1', :formula_id => '0', :formula_ord => '1' )

sed "s/^/Link.create( :graph_id => '/" $1 |\
sed "s/\t/', :pinname_id => '/"  |\
sed "s/\t/', :pinname_ord => '/" |\
sed "s/\t/', :formula_id => '/"  |\
sed "s/\t/', :formula_ord => '/" |\
sed "s/$/' )/"

#________________________________________________________

# Link.create( :graph_id => '001.001.c', :pinname_id => '4', :pinname_ord => '1', :formula_id => '4', :formula_ord => '1' )
# Link.create( :graph_id => '001.001.c', :pinname_id => '4', :pinname_ord => '1', :formula_id => '5', :formula_ord => '2' )
# Link.create( :graph_id => '001.001.c', :pinname_id => '5', :pinname_ord => '2', :formula_id => '4', :formula_ord => '1' )
# Link.create( :graph_id => '001.001.c', :pinname_id => '5', :pinname_ord => '2', :formula_id => '5', :formula_ord => '2' )

# UPDATE links SET pinname_id='4', formula_id='4' WHERE graph_id='001.001.c' AND pinname_ord='1' AND formula_ord='1' ;
# UPDATE links SET pinname_id='4', formula_id='5' WHERE graph_id='001.001.c' AND pinname_ord='1' AND formula_ord='2' ;
# UPDATE links SET pinname_id='5', formula_id='4' WHERE graph_id='001.001.c' AND pinname_ord='2' AND formula_ord='1' ;
# UPDATE links SET pinname_id='5', formula_id='5' WHERE graph_id='001.001.c' AND pinname_ord='2' AND formula_ord='2' ;


cut -f 1      -d ' ' proto_link_join_seeds.rb | sed "s/Link.create(/UPDATE links /" > temp_links_prefix.txt
cut -f 2-4    -d ' ' proto_link_join_seeds.rb | sed "s/:/WHERE /" | sed "s/,//"     > temp_links_graph_id.txt
cut -f 5-7    -d ' ' proto_link_join_seeds.rb | sed "s/:/SET /"                     > temp_links_pinname_id.txt
cut -f 8-10   -d ' ' proto_link_join_seeds.rb | sed "s/:/AND /"   | sed "s/,//"     > temp_links_pinname_ord.txt
cut -f 11-13  -d ' ' proto_link_join_seeds.rb | sed "s/://"       | sed "s/,//"     > temp_links_formula_id.txt
cut -f 14-16  -d ' ' proto_link_join_seeds.rb | sed "s/:/AND /"                     > temp_links_formula_ord.txt
cut -f 17     -d ' ' proto_link_join_seeds.rb | sed "s/)/;/"                        > temp_links_suffix.txt

# paste temp_main_a_uniq.csv temp_ord_uniq.csv temp_main_b_uniq.csv > temp_paste_uniq.csv
   paste -d ' ' temp_links_prefix.txt \
		temp_links_pinname_id.txt \
		temp_links_formula_id.txt \
		temp_links_graph_id.txt \
		temp_links_pinname_ord.txt \
		temp_links_formula_ord.txt \
		temp_links_suffix.txt > temp_links_paste_all.txt

sed "s/ => /=/g" temp_links_paste_all.txt 

# sqlite3 development.sqlite3 \
"UPDATE links  SET pinname_id='1', formula_id='1' WHERE graph_id='001.001.0' AND pinname_ord='1' AND formula_ord='1' ; "




