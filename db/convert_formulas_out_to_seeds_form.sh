  sed "s/,[ 'a-z0-9_.]*,[ 'a-z0-9_.]*);/);/" < $1 \
| sed "s/insert into all_forms values/Formula.create/" \
| sed "s/'_'/'0'/" >  temp1.sql

  sed "s/( /( :base => '/"  < temp1.sql \
| sed "s/, /'@ :offset => '/" \
| sed "s/, /'@ :subindex => /" \
| sed "s/, /@ :ord => '/" \
| sed "s/, /'@ :iform => /" \
| sed "s/, /@ :word_form => /" \
| sed "s/, /@ :abbrev_form => /" \
| sed "s/, /@ :alpha => /" \
| sed "s/@/,/g" 


