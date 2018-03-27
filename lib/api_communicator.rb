require 'JSON'
require 'rest-client'
require 'pry'
 

def crime_data
	x = RestClient.get('https://data.cityofnewyork.us/resource/9s4h-37hy.json')
	cd = JSON.parse(x)
end


def retrieve_array_of_crimes
	crime_data.map do |complaint|
		complaint["ofns_desc"]
	end
end

puts retrieve_array_of_crimes