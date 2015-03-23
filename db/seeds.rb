# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Place.create([
  {
    id: "9841",
    url_name: "somerville_2",
    name: "Somerville",
    state: "MA",
    json: '{"id":9841,"url_name":"somerville_2","name":"Somerville","county":null,"state":"MA","data_classification":"City","created_at":"2009-09-20T20:21:38-04:00","updated_at":"2014-03-03T10:06:07-05:00"}'
  }
])
