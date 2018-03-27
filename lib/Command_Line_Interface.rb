

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








	def runner
	end
