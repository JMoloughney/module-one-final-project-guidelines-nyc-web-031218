class CreateCriminalActsTable < ActiveRecord::Migration[5.1]

	def change
		create_table :criminal_acts do |t|
			t.integer :complaint_num
			t.float :latitude
			t.integer :crime_id
			t.integer :location_id
		end
	end

end