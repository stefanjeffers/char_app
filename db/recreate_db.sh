ruby generate_ord_values.rb chinese_db_table_prep.csv
cat proto_link_seeds.rb  proto_pinname_seeds.rb  proto_formula_seeds.rb > seeds.rb

# But note: reset seems to include rake db:seed. That's why it is taking so long now.

bundle exec rake db:reset
bundle exec rake db:populate
# bundle exec rake db:seed
bundle exec rake db:test:prepare

