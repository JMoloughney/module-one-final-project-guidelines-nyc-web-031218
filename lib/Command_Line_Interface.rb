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
  cust_border
	x = count.max_by{|k,v| v}
  puts "The most dangerous borough in NYC is currently #{x[0].capitalize}, with a crime total of #{x[1]}".colorize(:white)
  cust_border
end


def least_dangerous_borough
	count = {}
	bor = Location.all.map {|loc| loc.name}.uniq
	bor.each do |bor|
		count[bor] = num_of_crimes(bor)
	end
	cust_border
  x = count.min_by{|k,v| v}
  puts "The safest borough in NYC is currently #{x[0].capitalize}, with a crime total of #{x[1]}".colorize(:white)
  cust_border
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
    sub_dash
    puts "#{v}".colorize(:white)
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
    sub_dash
    puts "#{v}".colorize(:white)
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
 		puts "#{k}:".colorize(:yellow)
    sub_dash
    puts "#{v}"
 	end
 end


 def freq_crime_type_by_month(name)
 	arr = grab_months
 	typ = arr.each_with_object({}){|month, hash| hash[month] = Hash.new(0)}

 	get_borough(name).each do |loc|
 		loc.crimes.each do |cr|
 			month = cr.date_of_crime.split("-")[1]
 			typ[month][cr.offense] += 1
 		end
 	end
  header_border
 	puts "These are the crime type rates by month in your borough:".colorize(:white)
  header_border
 	typ.each do |k,v|
 		 dash
    puts Date::MONTHNAMES[k.to_i].colorize(:yellow)
      sub_dash
 		v.each do |k,v|
 			puts "#{k}: #{v}" if k
 		end
 	end
 end


 def grab_months
	Crime.all.map do |cr|
		cr.date_of_crime.split("-")[1]
	end.uniq.sort
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
    puts "#{k}:".colorize(:yellow)
    puts "#{v}"
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
 			month = cr.date_of_crime.split("-")[1]
 			typ[month][cr.offense] += 1
 		end
 	end
  header_border
   	puts "These are the crime type rates by month in NYC:".colorize(:white)
  header_border
 	typ.each do |k,v|
    dash
    puts Date::MONTHNAMES[k.to_i].colorize(:yellow)
 		sub_dash
 		v.each do |k,v|
 			puts "#{k}: #{v}" if k
 		end
 	end
  dash
 end




#|||||||||||| CLI-FORMAT/DESIGN methods|||||||||||||||||||||||||||

def dash
  puts "------------------------------------"
end

def sub_dash
  puts "--------------------"
end

def header_border
  puts "==========================================================="
end

def cust_border
  puts "=================================================================="
end

def title_border
  puts "++++----^v^--^v^v^-^v^-----++++"
end

def spacer
  puts "                         "
end

def creater_border
puts "<><><><><><><><><><><><><><><><><><><><><><>><><>"
end

#|||||||||||||||HELPER/CHECKER METHODS||||||||||||||||||

def borough_input_valid?(input)
  input == "1" || input == "2" || input == "3" || input == "4" || input == "5"
end

def borough_name_valid?(name)
  name.downcase == "brooklyn" || name.downcase == "manhattan" || name.downcase == "queens" || name.downcase == "staten island" || name.downcase == "bronx"
end

def city_input_valid?(input)
  input == "1" || input == "2" || input == "3" || input == "4" || input == "5" || input == "6"
end


#||||||||||||||MAIN APP METHODS||||||||||||||||||||||


 def greet
    title_border
    puts "Welcome to NYC Safety Net!".colorize(:red)
    title_border
    spacer
    spacer
 end


  def main_menu
    message = [
      "What would you like to do?:".colorize(:yellow),
      "1 : Check Criminal Activity by Borough".colorize(:white),
      "2 : Check Criminal Activity by City-Wide".colorize(:white),
      "3 : Exit".colorize(:white)
    ]
    header_border
    puts message
    header_border
    puts "Please enter one of the numbered commands:"
    dash
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
    cust_border
    puts  "We thank you for your visit, we hope you found this".colorize(:white)
    puts  "information useful today & most importantly; Stay Safe Out There!!".colorize(:white)
    cust_border
    creater_border
    puts  "-From your creators of NYC SafeNet: Helen & Joe".colorize(:yellow)
    creater_border
  end



#|||||BOROUGH MENUS|||||

def sub_menu_boroughs
message = [
      "What would you like to do?:".colorize(:yellow),
      "1 : View number of crimes".colorize(:white),
      "2 : View breakdown of crime types".colorize(:white),
      "3 : View hot-spot crime areas".colorize(:white),
      "4 : View breakdown severity of crimes".colorize(:white),
      "5 : View monthly breakdown of types of crimes".colorize(:white),
      "6 : Exit Sub-Menu".colorize(:white),
    ]
    header_border
    puts message
    header_border
    puts "Please enter one of the numbered commands:"
    dash
		input = gets.chomp
    sub_dash
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
	header_border
  puts "Please name the borough:"
  header_border
	name = gets.chomp
  dash
  spacer
  spacer
	if !borough_name_valid?(name)
		puts "Please enter a valid borough name."
		menu_input_borough(input)
	else
	  case input
		  when "1"
        header_border
		    x = num_of_crimes(name)
				puts "#{name.capitalize} has a crime total of #{x}.".colorize(:yellow)
        header_border
        spacer
        spacer
        spacer
		 	when "2"
		    type_of_crimes_borough(name)
		  when "3"
		  	freq_crime_spots(name)
		  when "4"
		  	freq_crime_level(name)
		  when "5"
		  	freq_crime_type_by_month(name)
			when "6"
				main_menu
	  end
	  sub_menu_boroughs
	end
end



#|||||CITY-WIDE MENUS|||||

def sub_menu_city
message = [
      "What would you like to do?:".colorize(:yellow),
      "1 : View breakdown of crime types".colorize(:white),
      "2 : View hot-spot crime areas".colorize(:white),
      "3 : View breakdown severity of crimes".colorize(:white),
      "4 : View monthly breakdown of types of crimes".colorize(:white),
      "5 : Current Dangerous Borough".colorize(:white),
      "6 : Current Safest Borough".colorize(:white),
      "7 : Exit Sub-Menu".colorize(:white),
    ]
    header_border
    puts message
    header_border
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
		    	nyc_crime_freq_by_month
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
