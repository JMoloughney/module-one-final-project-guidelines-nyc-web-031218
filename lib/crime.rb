class Crime < ActiveRecord::Base
	has_many :criminal_acts
	has_many :locations, through: :criminal_acts
end