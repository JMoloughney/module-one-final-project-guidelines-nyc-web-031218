require 'JSON'
require 'rest-client'
require 'pry'


def crime_data
	x = RestClient.get('https://data.cityofnewyork.us/resource/9s4h-37hy.json?$limit=3000&$offset=95000')
	cd = JSON.parse(x)
end

