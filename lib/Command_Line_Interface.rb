#|||||||||||BOROUGH METHODS||||||||||||||||

require 'colorize'
require 'date'


def get_borough(name)
	Location.all.select do |loc|
		loc.name.downcase == name.downcase
	end
end


def num_of_crimes(name)
	get_borough(name).length
end


def most_dangerous_borough
	count = {}
	bor = Location.all.map {|loc| loc.name}.uniq
	bor.each do |bor|
		count[bor] = num_of_crimes(bor)
	end
	x = count.max_by{|k,v| v}
	header_border
  puts "The most dangerous borough in NYC is currently #{x[0].capitalize}, with a crime total of #{x[1]}".colorize(:white)
  header_border
end


def least_dangerous_borough
	count = {}
	bor = Location.all.map {|loc| loc.name}.uniq
	bor.each do |bor|
		count[bor] = num_of_crimes(bor)
	end
	x = count.min_by{|k,v| v}
	header_border
  puts "The safest borough in NYC is currently #{x[0].capitalize}, with a crime total of #{x[1]}".colorize(:white)
  header_border
end


 def type_of_crimes_borough(name)
 	typ = Hash.new(0)
 	get_borough(name).each do |loc|
 		loc.crimes.each do |cr|
 			typ[cr.offense] += 1
 		end
 	end
  header_border
 	puts "These are the frequent crime types in your borough:".colorize(:white)
  header_border
 	  dash
  typ.each do |k,v|
    if k
    puts "#{k}:".colorize(:yellow)
    puts "#{v}"
    dash
  end
 end
 end


 def freq_crime_spots(name)
 	typ = Hash.new(0)
 	get_borough(name).each do |loc|
 		typ[loc.scene_of_crime] +=1
 	end
  header_border
 	puts "These are the frequent crime spots in your borough:".colorize(:white)
  header_border
 	  dash
  typ.each do |k,v|
    if k
    puts "#{k}:".colorize(:yellow)
    puts "#{v}"
    dash
  end
 end
 end

def freq_crime_level(name)
	typ = Hash.new(0)
 	get_borough(name).each do |loc|
 		loc.crimes.each do |cr|
 			typ[cr.severity] += 1
 		end
 	end
  header_border
 	puts "These are the crime level frequencies in your borough:".colorize(:white)
  header_border
 	typ.each do |k,v|
 		puts "#{k}: #{v}" if k
 	end
 end


 def freq_crime_type_by_month(name, month)
 	arr = grab_months
 	typ = arr.each_with_object({}){|month, hash| hash[month] = Hash.new(0)}

 	get_borough(name).each do |loc|
 		loc.crimes.each do |cr|
 			num = cr.date_of_crime.split("-")[1]
			month = convert_num_to_month(num.to_i)
 			typ[month][cr.offense] += 1
 		end
 	end
	header_border
	 puts "These are the crime type rates by month in your borough:".colorize(:white)
	header_border
	typ
 end

 def print_crime_by_months(name, month)
	 if name
	 	typ = freq_crime_type_by_month(name, month)
	else
		typ = nyc_crime_freq_by_month
	end
	 	month_hash = typ.select{|k,v| k.downcase == month.downcase}
		month_hash.each do |k,v|
			 dash
		 puts k.colorize(:yellow)
			 sub_dash
			v.each do |k,v|
				puts "#{k}: #{v}" if k
			end
		end
		header_border
		 puts "Type another month. Otherwise, type anything else to exit.".colorize(:white)
		header_border
		month = gets.chomp

		if name
			 print_crime_by_months(name, month) if month_valid?(month)
		else
			print_crime_by_months(name = nil, month) if month_valid?(month)
		end
end


 def grab_months
	arr = Crime.all.map do |cr|
		cr.date_of_crime.split("-")[1].to_i
	end.uniq.sort

	arr.map do |m|
		convert_num_to_month(m)
	end
end


 #||||||||||||||||||CityWide Methods |||||||||||||||||||||||||||||


def nyc_crime_level
	typ = Hash.new(0)
 	Crime.all.map do |c|
 		typ[c.severity] += 1
 	end
  header_border
 	puts "These are the crime level frequencies in NYC:".colorize(:white)
  header_border
 	typ.each do |k,v|
 		if k
    puts "#{k}: #{v}"
    dash
 	end
 end
end


def nyc_freq_crime_spots
	typ = Hash.new(0)
	Location.all.map do |loc|
		typ[loc.scene_of_crime] += 1
 	end
  header_border
 	puts "These are the crime hot-spots in NYC:".colorize(:white)
  header_border
 	  dash
  typ.each do |k,v|
    if k
    puts "#{k}:".colorize(:yellow)
    puts "#{v}"
    dash
  end
 end
 end


 def nyc_freq_crime_type
 	typ = Hash.new(0)
 	Crime.all.map do |c|
 			typ[c.offense] += 1
 		end
  header_border
 	puts "These are the frequent types of crimes committed in NYC:".colorize(:white)
  header_border
 	dash
  typ.each do |k,v|
    if k
    puts "#{k}:".colorize(:yellow)
    puts "#{v}"
    dash
 	end
 end
 end


 def nyc_crime_freq_by_month
 	arr = grab_months
 	typ = arr.each_with_object({}){|month, hash| hash[month] = Hash.new(0)}
 	Location.all.each do |loc|
 		loc.crimes.each do |cr|
			num = cr.date_of_crime.split("-")[1]
			month = convert_num_to_month(num.to_i)
 			typ[month][cr.offense] += 1
 		end
 	end
  header_border
   	puts "These are the crime type rates by month in NYC:".colorize(:white)
  header_border
	typ
 end




#|||||||||||| CLI-FORMAT/DESIGN methods|||||||||||||||||||||||||||

def dash
  puts "------------------------------------"
end

def sub_dash
  puts "-------------"
end

def header_border
  puts "============================================================="
end


def title_border
  puts "+========================+"
end

def spacer
  puts "                         "
end

def creater_border
puts "<><><><><><><><><><><><><><><><><><><><><><>><><>"
end

#|||||||||||||||HELPER/CHECKER METHODS||||||||||||||||||

def borough_input_valid?(input)
	(1..5).include?(input.to_i)
end

def borough_name_valid?(name)
  name.downcase == "brooklyn" || name.downcase == "manhattan" || name.downcase == "queens" || name.downcase == "staten island" || name.downcase == "bronx"
end

def city_input_valid?(input)
	(1..6).include?(input.to_i)
end

def month_valid?(input)
	grab_months.include?(input.capitalize)
end

def convert_num_to_month(num)
	Date::MONTHNAMES[num]
end

#||||||||||||||MAIN APP METHODS||||||||||||||||||||||


 def greet
    title_border
    puts "Welcome to NYC Safety Net!".colorize(:red)
    title_border
    spacer
 end


  def main_menu
    message = [
      "What would you like to do?:".colorize(:yellow),
      dash,
      "1 : Check Criminal Activity by Borough".colorize(:white),
      "2 : Check Criminal Activity by City-Wide".colorize(:white),
      "3 : Exit".colorize(:white)
    ]
    puts message
    puts "Please enter one of the numbered commands:"
    menu_input
  end

  def menu_input
    input = gets.chomp
      case input

      when "1"
        sub_menu_boroughs
      when "2"
        sub_menu_city
      when "3"
        exit_menu
      else
        puts "Please enter one of the valid commands: #{input} is NOT a command!"
        menu_input
      end
  end


   def exit_menu
    spacer
    header_border
    puts  "We thank you for your visit, we hope you found this".colorize(:white)
    puts  "information useful today & most importantly; Stay Safe Out There!!".colorize(:white)
    header_border
    creater_border
    puts  "-From your creators of NYC SafeNet: Helen & Joe".colorize(:yellow)
    creater_border
  end



#|||||BOROUGH MENUS|||||

def sub_menu_boroughs
message = [dash,
      "What would you like to do?:".colorize(:yellow),
      dash,
      "1 : View number of crimes".colorize(:white),
      "2 : View breakdown of crime types".colorize(:white),
      "3 : View hot-spot crime areas".colorize(:white),
      "4 : View breakdown severity of crimes".colorize(:white),
      "5 : View monthly breakdown of types of crimes".colorize(:white),
      "6 : Exit Sub-Menu".colorize(:white),
    ]
    puts message
    puts "Please enter one of the numbered commands:"
		input = gets.chomp

		if input == "6"
			main_menu
		elsif !borough_input_valid?(input)
			puts "Please enter one of the valid commands: #{input} is NOT a command!"
			sub_menu_boroughs
		else
    	menu_input_borough(input)
		end
end


def menu_input_borough(input)
	puts "Please name the borough:"
	name = gets.chomp

	if !borough_name_valid?(name)
		puts "Please enter a valid borough name."
		menu_input_borough(input)
	else
	  case input
		  when "1"
		    x = num_of_crimes(name)
				puts "#{name.capitalize} has a crime total of #{x}."
		 	when "2"
		    type_of_crimes_borough(name)
		  when "3"
		  	freq_crime_spots(name)
		  when "4"
		  	freq_crime_level(name)
		  when "5"
				message = [dash,
							"Type in the month you want to view:".colorize(:yellow),
							dash
						]
				puts message
				month = gets.chomp
				if month_valid?(month)
					print_crime_by_months(name, month)
				else
					puts "That is not a valid month."
				end
			when "6"
				main_menu
	  end
	  sub_menu_boroughs
	end
end



#|||||CITY-WIDE MENUS|||||

def sub_menu_city
message = ["What would you like to do?:".colorize(:yellow),
      dash,
      "1 : View breakdown of crime types".colorize(:white),
      "2 : View hot-spot crime areas".colorize(:white),
      "3 : View breakdown severity of crimes".colorize(:white),
      "4 : View monthly breakdown of types of crimes".colorize(:white),
      "5 : Current Dangerous Borough".colorize(:white),
      "6 : Current Safest Borough".colorize(:white),
      "7 : Exit Sub-Menu".colorize(:white),
    ]
    puts message
    puts "Please enter one of the numbered commands:"
    dash
    menu_input_city
end


def menu_input_city
	input = gets.chomp
    if input == "7"
    	main_menu
		elsif !city_input_valid?(input)
			puts "Please enter one of the valid commands: #{input} is NOT a command!"
			menu_input_city
    else
	    case input
		    when "1"
		      nyc_freq_crime_type
		   	when "2"
		      nyc_freq_crime_spots
		    when "3"
		    	nyc_crime_level
		    when "4"
					message = [dash,
								"Type in the month you want to view:".colorize(:yellow),
								dash
							]
					puts message
					month = gets.chomp

					if month_valid?(month)
						print_crime_by_months(name = nil, month)
					else
						puts "That is not a valid month."
					end

		    when "5"
		    	most_dangerous_borough
		    when "6"
		    	least_dangerous_borough
		    when "7"
		    	main_menu
    	end
	  	sub_menu_city
		end
  end




#|||||||||||||RUNS THE ENTIRE APP IN CONSOLE with "ruby ./bin/run.rb" ||||||||||||||||||||||



	def runner
    greet
		main_menu
	end
