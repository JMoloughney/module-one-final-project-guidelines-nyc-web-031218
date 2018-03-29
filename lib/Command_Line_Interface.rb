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
  cust_border2
	x = count.max_by{|k,v| v}
  puts "The most dangerous borough in NYC is currently #{x[0].capitalize}, with a crime total of #{x[1]}".colorize(:white)
  cust_border2
end


def least_dangerous_borough
	count = {}
	bor = Location.all.map {|loc| loc.name}.uniq
	bor.each do |bor|
		count[bor] = num_of_crimes(bor)
	end
	cust_border2
  x = count.min_by{|k,v| v}
  puts "The safest borough in NYC is currently #{x[0].capitalize}, with a crime total of #{x[1]}".colorize(:white)
  cust_border2
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
 	spacer
  spacer
  header_border
  typ.each do |k,v|
    if k
    puts ("#{k}:".capitalize.colorize(:yellow)) + ("#{v}".colorize(:white))
    header_border
  end
 end
 spacer
 spacer
 end


 def freq_crime_spots(name)
 	typ = Hash.new(0)
 	get_borough(name).each do |loc|
 		typ[loc.scene_of_crime] +=1
 	end
  header_border
 	puts "These are the frequent crime spots in your borough:".colorize(:white)
  header_border
 	spacer
  spacer
  header_border
  typ.each do |k,v|
    if k
    puts ("#{k}:".capitalize.colorize(:yellow)) + ("#{v}".colorize(:white))
    header_border
  end
 end
 spacer
 spacer
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
  spacer
  spacer
  header_border
 	typ.each do |k,v|
 		puts ("#{k}:".capitalize.colorize(:yellow)) + "#{v}"
    header_border
 	end
  spacer
  spacer
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
			 equals_border
		 puts k.colorize(:white)
       equals_border
			v.each do |k,v|
				puts "#{k.capitalize.colorize(:yellow)}: #{v}" if k
      dash
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
  spacer
  spacer
 	typ.each do |k,v|
 		if k
    puts "#{k}:".capitalize.colorize(:yellow)
    puts "#{v}"
    header_border
 	end
 end
 spacer
 spacer
end


def nyc_freq_crime_spots
	typ = Hash.new(0)
	Location.all.map do |loc|
		typ[loc.scene_of_crime] += 1
 	end
  header_border
 	puts "These are the crime hot-spots in NYC:".colorize(:white)
  header_border
 	spacer
  spacer
  header_border
  typ.each do |k,v|
    if k
    puts ("#{k}:".capitalize.colorize(:yellow)) + "#{v}"
    header_border
  end
 end
 spacer
 spacer
 end


 def nyc_freq_crime_type
 	typ = Hash.new(0)
 	Crime.all.map do |c|
 			typ[c.offense] += 1
 		end
  header_border
 	puts "These are the frequent types of crimes committed in NYC:".colorize(:white)
  header_border
 	spacer
  spacer
  header_border
  typ.each do |k,v|
    if k
    puts ("#{k}:".capitalize.colorize(:yellow)) + "#{v}"
    header_border
 	end
 end
 spacer
 spacer
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
  spacer
  spacer
	typ
 end




#|||||||||||| CLI-FORMAT/DESIGN methods|||||||||||||||||||||||||||

def dash
  puts "------------------------------------"
end

def equals_border
  puts "======================================"
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

def cust_border2
  puts "==================================================================================="
end

def title_border
  puts "++++-------^v^--^v^v^-^v^--------------^v^v^----------^v^--^v^v^-^v^---------++++"
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
    spacer
    puts "
       _     _  _______  ___      _______  _______  __   __  _______ 
      | | _ | ||       ||   |    |       ||       ||  |_|  ||       |              
      | || || ||    ___||   |    |       ||   _   ||       ||    ___|              
      |       ||   |___ |   |    |       ||  | |  ||       ||   |___               
      |       ||    ___||   |___ |      _||  |_|  ||       ||    ___|              
      |   _   ||   |___ |       ||     |_ |       || ||_|| ||   |___               
      |__| |__||_______||_______||_______||_______||_|   |_||_______|              
                         _______  _______                                          
                        |       ||       |                                         
                        |_     _||   _   |                                         
                          |   |  |  | |  |                                         
                          |   |  |  |_|  |                                         
                          |   |  |       |                                         
                          |___|  |_______|                                         
 _______  _______  _______  _______  _______  __   __    __    _  _______  _______ 
|       ||   _   ||       ||       ||       ||  | |  |  |  |  | ||       ||       |
|  _____||  |_|  ||    ___||    ___||_     _||  |_|  |  |   |_| ||    ___||_     _|
| |_____ |       ||   |___ |   |___   |   |  |       |  |       ||   |___   |   |  
|_____  ||       ||    ___||    ___|  |   |  |_     _|  |  _    ||    ___|  |   |  
 _____| ||   _   ||   |    |   |___   |   |    |   |    | | |   ||   |___   |   |  
|_______||__| |__||___|    |_______|  |___|    |___|    |_|  |__||_______|  |___|                   
          " 
    spacer
    title_border
    spacer
 end


  def main_menu
    puts " 
__   __ _______ ___ __    _      __   __ _______ __    _ __   __ 
|  |_|  |   _   |   |  |  | |    |  |_|  |       |  |  | |  | |  |
|       |  |_|  |   |   |_| |____|       |    ___|   |_| |  | |  |
|       |       |   |       |____|       |   |___|       |  |_|  |
|       |       |   |  _    |    |       |    ___|  _    |       |
| ||_|| |   _   |   | | |   |    | ||_|| |   |___| | |   |       |
|_|   |_|__| |__|___|_|  |__|    |_|   |_|_______|_|  |__|_______|"
    spacer
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
  puts " 
 _______  _______  _______  __   __    __   __  _______  _______  _______  _______  ______        
|       ||       ||   _   ||  | |  |  |  | |  ||       ||   _   ||       ||       ||      |       
|  _____||_     _||  |_|  ||  |_|  |  |  | |  ||    _  ||  |_|  ||_     _||    ___||  _    |      
| |_____   |   |  |       ||       |  |  |_|  ||   |_| ||       |  |   |  |   |___ | | |   |      
|_____  |  |   |  |       ||_     _|  |       ||    ___||       |  |   |  |    ___|| |_|   | ___  
 _____| |  |   |  |   _   |  |   |    |       ||   |    |   _   |  |   |  |   |___ |       ||_  | 
|_______|  |___|  |__| |__|  |___|    |_______||___|    |__| |__|  |___|  |_______||______|   |_| 
         _______  _______  _______  __   __    _______  _______  _______  _______   ____              
        |       ||       ||   _   ||  | |  |  |       ||   _   ||       ||       | |    |           
        |  _____||_     _||  |_|  ||  |_|  |  |  _____||  |_|  ||    ___||    ___| |    |          
        | |_____   |   |  |       ||       |  | |_____ |       ||   |___ |   |___  |    |            
        |_____  |  |   |  |       ||_     _|  |_____  ||       ||    ___||    ___| |____|           
         _____| |  |   |  |   _   |  |   |     _____| ||   _   ||   |    |   |___   ____           
        |_______|  |___|  |__| |__|  |___|    |_______||__| |__||___|    |_______| |____|"

    spacer
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

"_______  _______  ______    _______  __   __  _______  __   __        __   __  _______  __    _  __   __ 
|  _    ||       ||    _ |  |       ||  | |  ||       ||  | |  |      |  |_|  ||       ||  |  | ||  | |  |
| |_|   ||   _   ||   | ||  |   _   ||  | |  ||    ___||  |_|  | ____ |       ||    ___||   |_| ||  | |  |
|       ||  | |  ||   |_||_ |  | |  ||  |_|  ||   | __ |       ||____||       ||   |___ |       ||  |_|  |
|  _   | |  |_|  ||    __  ||  |_|  ||       ||   ||  ||       |      |       ||    ___||  _    ||       |
| |_|   ||       ||   |  | ||       ||       ||   |_| ||   _   |      | ||_|| ||   |___ | | |   ||       |
|_______||_______||___|  |_||_______||_______||_______||__| |__|      |_|   |_||_______||_|  |__||_______|",
      spacer,
      "What would you like to do?:".colorize(:yellow),
      "1 : View number of crimes".colorize(:white),
      "2 : View breakdown of crime types".colorize(:white),
      "3 : View hot-spot crime areas".colorize(:white),
      "4 : View breakdown severity of crimes".colorize(:white),
      "5 : View monthly breakdown of types of crimes".colorize(:white),
      "6 : Exit Sub-Menu".colorize(:white),
    ]
    puts message
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
        spacer
        spacer
		    x = num_of_crimes(name)
        cust_border
				puts "#{name.capitalize} has a crime total of #{x}.".colorize(:yellow)
        cust_border
		 	when "2"
        spacer
        spacer
		    type_of_crimes_borough(name)
		  when "3"
        spacer
        spacer
		  	freq_crime_spots(name)
		  when "4"
        spacer
        spacer
		  	freq_crime_level(name)
		  when "5"
        spacer
        spacer
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
        spacer
				main_menu
	  end
    spacer
	  sub_menu_boroughs
	end
end



#|||||CITY-WIDE MENUS|||||

def sub_menu_city
message = [" 
 _______ ___ _______ __   __      _     _ ___ ______  _______   __   __ _______ __    _ __   __ 
|       |   |       |  | |  |    | | _ | |   |      ||       | |  |_|  |       |  |  | |  | |  |
|      _|   |_     _|  |_|  |____| || || |   |  _    |    ___| |       |    ___|   |_| |  | |  |
|     | |   | |   | |       |____|       |   | | |   |   |___  |       |   |___|       |  |_|  |
|     | |   | |   | |_     _|    |       |   | |_|   |    ___| |       |    ___|  _    |       |
|     |_|   | |   |   |   |      |   _   |   |       |   |___  | ||_|| |   |___| | |   |       |
|_______|___| |___|   |___|      |__| |__|___|______||_______| |_|   |_|_______|_|  |__|_______|",
spacer,
      "What would you like to do?:".colorize(:yellow),
      "1 : View breakdown of crime types".colorize(:white),
      "2 : View hot-spot crime areas".colorize(:white),
      "3 : View breakdown severity of crimes".colorize(:white),
      "4 : View monthly breakdown of types of crimes".colorize(:white),
      "5 : Current Dangerous Borough".colorize(:white),
      "6 : Current Safest Borough".colorize(:white),
      "7 : Exit Sub-Menu".colorize(:white)]
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
          spacer
		      nyc_freq_crime_type
		   	when "2"
          spacer
		      nyc_freq_crime_spots
		    when "3"
          spacer
          spacer
		    	nyc_crime_level
		    when "4"
          spacer
          spacer
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
          spacer
          spacer
		    	most_dangerous_borough
		    when "6"
          spacer
          spacer
		    	least_dangerous_borough
		    when "7"
          spacer
		    	main_menu
    	end
      spacer
	  	sub_menu_city
		end
  end




#|||||||||||||RUNS THE ENTIRE APP IN CONSOLE with "ruby ./bin/run.rb" ||||||||||||||||||||||



	def runner
    greet
		main_menu
	end
