class CriminalAct < ActiveRecord::Base
	belongs_to :location
	belongs_to :crime
end