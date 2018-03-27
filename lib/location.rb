class Location < ActiveRecord::Base
	has_many :criminal_acts
	has_many :crimes, through: :criminal_acts
end