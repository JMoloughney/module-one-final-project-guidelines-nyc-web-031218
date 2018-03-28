
require 'pry'
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
	x = count.max_by{|k,v| v}
	puts "The most dangerous borough is currently #{x[0].capitalize}, with a crime total of #{x[1]}"
end


def least_dangerous_borough
	count = {}
	bor = Location.all.map {|loc| loc.name}.uniq
	bor.each do |bor|
		count[bor] = num_of_crimes(bor)
	end
	x = count.min_by{|k,v| v}
	puts "The safest borough is currently #{x[0].capitalize}, with a crime total of #{x[1]}"
end


 def type_of_crimes_borough(name)
 	typ = Hash.new(0)
 	get_borough(name).each do |loc|
 		loc.crimes.each do |cr|
 			typ[cr.offense] += 1
 		end
 	end
 	puts "These are frequent crime types in your borough:"
 	typ.each do |k,v|
 		puts "#{k}:#{v}"
 	end
 end


 def freq_crime_spots(name)
 	typ = Hash.new(0)
 	get_borough(name).each do |loc|
 		typ[loc.scene_of_crime] +=1
 	end
 	puts "These are frequent crime spots in your borough:"
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
 	puts "These are crime level frequencies in your borough:"
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
 	typ
 end

 def grab_months
	Crime.all.map do |cr|
		cr.date_of_crime.split("-")[1]
	end.uniq.sort
end


 #city-wide menu


def nyc_crime_level
	typ = Hash.new(0)
 	Crime.all.map do |c|
 		typ[c.severity] += 1
 	end
 	typ
end


def nyc_freq_crime_spots
	typ = Hash.new(0)
	Location.all.map do |loc|
		typ[loc.scene_of_crime] += 1
 	end
 	typ
 end


 def nyc_freq_crime_type
 	typ = Hash.new(0)
 	Crime.all.map do |c|
 			typ[c.offense] += 1
 		end
 	typ
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
 	typ
 end





 def greet
    puts "Welcome to NYC Safety Net!"
 end


  def main_menu
    message = [
      "What would you like to do?:",
      "1 : Check Criminal Activity by Borough",
      "2 : Check Criminal Activity by City-Wide",
      "3 : Exit"
    ]
    puts message
    puts "Please enter one of the numbered commands:"
    menu_input
  end

def sub_menu_boroughs
message = [
      "What would you like to do?:",
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
	puts "Please name the borough:"
	name = gets.chomp
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


def sub_menu_city
message = [
      "What would you like to do?:",
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
    menu_input_city
end




def menu_input_city
	input = gets.chomp
    if input == "7"
     	main_menu
     else
    case input
    when "1"
        puts nyc_freq_crime_type
   	when "2"
        puts nyc_freq_crime_spots
    when "3"
    	puts nyc_crime_level
    when "4"
    	puts nyc_crime_freq_by_month
    when "5"
    	puts most_dangerous_borough
    when "6"
    	puts least_dangerous_borough
    when "7"
    	main_menu
      else
        puts "Please enter one of the valid commands: #{input} is NOT a command!"
        menu_input
      end
      sub_menu_city
  	end
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
    puts "Goodbye! Stay Safe Out There!"
  end






	def runner
		greet
		main_menu
	end
