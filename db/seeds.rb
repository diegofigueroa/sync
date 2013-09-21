# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

GithubSettings.create username: "nasasync", client_id: "9d290ef49d7aa71409d2", client_secret: "8dad57de0fa3fcb8e4775d25541e7ded62b70a5d"
License.create title: 'NASA Open Source Agreement'
License.create title: 'Apache Version 2.0'
License.create title: 'BSD'
License.create title: 'GPL 3'