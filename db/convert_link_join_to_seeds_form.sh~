# graph_id	id	ord	graph_id	id	ord
# 001.001.0	1	1	001.001.0	1	1

# Link.create( :graph_id => '001.001.0', :pinname_id => '0', :pinname_ord => '1', :formula_id => '0', :formula_ord => '1' )

sed "s/^/Link.create( :graph_id => '/" $1 |\
sed "s/\t/', :pinname_id => '/"  |\
sed "s/\t/', :pinname_ord => '/" |\
sed "s/\t/', :formula_id => '/"  |\
sed "s/\t/', :formula_ord => '/" |\
sed "s/$/' )/"
