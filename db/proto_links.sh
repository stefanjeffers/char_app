  # But this will give a superset of the ones we want:
  # Will then need to match them up against the proto_link_seeds.rb version,
  #    and delete if equiv is not found there.

select pinnames.graph_id, pinnames.id, pinnames.ord, formulas.graph_id, formulas.id, formulas.ord
    from pinnames join formulas
       on pinnames.graph_id=formulas.graph_id
    where pinnames.base = '002';

sqlite3 dev*3 'select pinnames.graph_id, pinnames.id, pinnames.ord, formulas.id, formulas.ord \
		from pinnames join formulas on pinnames.graph_id=formulas.graph_id ;' > proto_link_join.txt




