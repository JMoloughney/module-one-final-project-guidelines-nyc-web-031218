require 'JSON'
require 'rest-client'
require 'pry'

 

def crime_data
	x = RestClient.get('https://data.cityofnewyork.us/resource/9s4h-37hy.json')
	cd = JSON.parse(x)
end





