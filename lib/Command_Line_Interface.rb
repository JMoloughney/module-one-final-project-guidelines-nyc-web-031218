

def get_borough(name)
	Location.all.select do |loc|
	loc.name.downcase == name.downcase
	end
end

def num_of_crimes(name)
	x = get_borough(name).length
end

def most_dangerous_borough
	count = {}
	bor = Location.all.map {|loc| loc.name}.uniq
	bor.each do |bor|
		count[bor] = num_of_crimes(bor)
	end
	count.max_by{|k,v| v}
end


def least_dangerous_borough
	count = {}
	bor = Location.all.map {|loc| loc.name}.uniq
	bor.each do |bor|
		count[bor] = num_of_crimes(bor)
	end
	count.min_by{|k,v| v}
end


def crime_ids
	Crime.all.map do |crime|
		crime.id
	end
end

def location_ids
	Location.all.map do |location|
		location.id
	end
end

 def type_of_crimes_borough(name)
 	typ = {}
 	get_borough(name).each do |loc|
 		loc.crimes.each do |cr|
 			typ[cr.offense] =+ 1
 		end
 	end
 	typ
 end


# def crime_by_location
# 	CriminalAct.all.select do |ca|
# 	end
# end

# def locatiom_by_crime
# 	CriminalAct.all.select do |ca|
#   end
# end





	def runner
	end
