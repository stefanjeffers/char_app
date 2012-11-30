sed "s/,[ 'a-z0-9_.]*,[ 'a-z0-9_.]*);/);/" < $1 > removed_fields_out.sql
# sed "s/ \d,//"
