# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', m: movies.first)

require 'uri'
require 'net/http'
require 'openssl'

url = URI('https://api.themoviedb.org/3/movie/top_rated?api_key=e5706d6ccfe6a4b85771611a7ba7f4f1')

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Get.new(url)
request['accept'] = 'application/json'

response = http.request(request)
data = JSON.parse(response.read_body)

Movie.destroy_all

path_pic = 'https://image.tmdb.org/t/p/w500/'
data['results'].each do |m|
  Movie.create(title: m['original_title'],
               overview: m['overview'],
               poster_url: path_pic + m['poster_path'],
               rating: m['vote_average'])
end
