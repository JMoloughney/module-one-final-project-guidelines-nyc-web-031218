#|||||||||||BOROUGH METHODS||||||||||||||||

require 'colorize'


def get_borough(name)
	Location.all.select do |loc|
	loc.name.downcase == name.downcase
	end
end

def num_of_crimes_in_borough(name)
	x = get_borough(name).length
end


def most_dangerous_borough
	count = {}
	bor = Location.all.map {|loc| loc.name}.uniq
	bor.each do |bor|
		count[bor] = num_of_crimes(bor)
	end
	x = count.max_by{|k,v| v}
	header_border
  puts "The most dangerous borough in NYC is currently #{x[0].capitalize}, with a crime total of #{x[1]}"
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
  puts "The safest borough in NYC is currently #{x[0].capitalize}, with a crime total of #{x[1]}"
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
 	puts "These are the frequent crime types in your borough:"
  header_border
 	typ.each do |k,v|
 		puts "#{k}:#{v}"
 	end
 end


 def freq_crime_spots(name)
 	typ = Hash.new(0)
 	get_borough(name).each do |loc|
 		typ[loc.scene_of_crime] +=1
 	end
  header_border
 	puts "These are the frequent crime spots in your borough:"
  header_border
 	typ.each do |k,v|
 		puts "#{k}:#{v}" 
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
 	puts "These are the crime level frequencies in your borough:"
  header_border
 	typ.each do |k,v|
 		puts "#{k}:#{v}" 
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
 	puts "These are the crime type rates by month in your borough:"
  header_border
 	typ.each do |k,v|
 		case k
 			when "01"
        dash
 				puts "January:"
 			when "02"
        dash
 				puts "February:"
 			when "03"
        dash
 				puts "March:"
 			when "04"
        dash
 				puts "April:"
 			when "05"
        dash
 				puts "May:"
 			when "06"
        dash
 				puts "June:"
 			when "07"
        dash
 				puts "July:"
 			when "08"
        dash
 				puts "August:"
 			when "09"
        dash
 				puts "September:"
 			when "10"
        dash
 				puts "October:"
 			when "11"
        dash
 				puts "November:"
 			when "12"
        dash
 				puts "December:"
 			end
      sub_dash
 		v.each do |k,v|
 			puts "#{k}:#{v}" 
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
 	puts "These are the crime level frequencies in NYC:"
  header_border
 	typ.each do |k,v|
 		puts "#{k}:#{v}" 
    dash
 	end
end


def nyc_freq_crime_spots
	typ = Hash.new(0)
	Location.all.map do |loc|
		typ[loc.scene_of_crime] += 1
 	end
  header_border
 	puts "These are the crime hot-spots in NYC:"
  header_border
 	  dash
  typ.each do |k,v|
 		puts "#{k}:
    #{v}"
    dash 
 	end
 end


 def nyc_freq_crime_type
 	typ = Hash.new(0)
 	Crime.all.map do |c|
 			typ[c.offense] += 1
 		end
  header_border
 	puts "These are the frequent types of crimes committed in NYC:"
  header_border
 	dash
  typ.each do |k,v|
    puts "#{k}:#{v}"
    dash 
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
   	puts "These are the crime type rates by month in NYC:"
  header_border
 	typ.each do |k,v|
 		case k
 			when "01"
 				dash
        puts "January:"
      when "02"
        dash
 				puts "February:"
 			when "03"
 				dash
        puts "March:"
 			when "04"
 				dash
        puts "April:"
 			when "05"
 				dash
        puts "May:"
 			when "06"
 				dash
        puts "June:"
 			when "07"
 				dash
        puts "July:"
 			when "08"
        dash
 				puts "August:"
 			when "09"
        dash
 				puts "September:"
 			when "10"
        dash
 				puts "October:"
 			when "11"
        dash
 				puts "November:"
 			when "12"
        dash
 				puts "December:"
 			end
 			sub_dash
 		v.each do |k,v|
 			puts "#{k}:#{v}" 
 		end
 	end
  dash
 end



#|||||||||||| CLI-FORMAT/DESIGN methods|||||||||||||||||||||||||||

def dash
  puts "----------------------------"
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



#||||||||||||||MAIN APP METHODS||||||||||||||||||||||



 def greet
    puts "Welcome to NYC Safety Net!".colorize(:red)
    title_border
    spacer
 end


  def main_menu
    message = [
      "What would you like to do?:".colorize(:red),
      dash,
      "1 : Check Criminal Activity by Borough",
      "2 : Check Criminal Activity by City-Wide",
      "3 : Exit"
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
    puts  "We thank you for your visit and, we hope you found this" 
    puts  "information useful today & most importantly, Stay Safe Out There!!" 
    header_border
    creater_border
    puts  "-From your creators of NYC SafeNet: Helen and Joe".colorize(:yellow)
    creater_border
    
  end



#|||||BOROUGH MENUS|||||

def sub_menu_boroughs
message = [dash,
      "What would you like to do?:".colorize(:red),
      dash,
      "1 : View number of crimes",
      "2 : View breakdown of crime types",
      "3 : View hot-spot crime areas",
      "4 : View breakdown severity of crimes",
      "5 : View monthly breakdown of types of crimes",
      "6 : Exit Sub-Menu",
    ]
    puts message
    puts "Please enter one of the numbered commands:"
    menu_input_borough
end


def menu_input_borough
	input = gets.chomp
	if input == "6"
		main_menu
	else
	puts "Please enter the name of your borough :"
	name = gets.chomp
  dash
    case input
     
    when "1"
        num_of_crimes(name)
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
      else
        puts "Please enter one of the valid commands: #{input} is NOT a command!"
        menu_input
      end
      sub_menu_boroughs
  end
  end


#|||||CITY-WIDE MENUS|||||

def sub_menu_city
message = ["What would you like to do?:".colorize(:red),
      dash,
      "1 : View breakdown of crime types",
      "2 : View hot-spot crime areas",
      "3 : View breakdown severity of crimes",
      "4 : View monthly breakdown of types of crimes",
      "5 : Current Dangerous Borough",
      "6 : Current Safest Borough",
      "7 : Exit Sub-Menu",
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
      else
        puts "Please enter one of the valid commands: #{input} is NOT a command!"
        menu_input
      end
      sub_menu_city
  	end
  end



#|||||||||||||RUNS THE ENTIRE APP IN CONSOLE with "ruby ./bin/run.rb" ||||||||||||||||||||||

	def runner
		title_border
    greet
		main_menu
	end
