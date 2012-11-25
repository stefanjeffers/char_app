# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

insert into pinnames values( 001, 046, '_', 3, 'shi4', 'show', 'R', 'noun', '001.046._', '001.046._.3');
Pinname.create( :base => '001', :offset => '046', :sub_index => '_', :ord => '3', 'shi4', 'show', 'R', 'noun', '001.046._', '001.046._.3');

