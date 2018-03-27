class CreateCrimesTable < ActiveRecord::Migration[5.1]

	def change
		create_table :crimes do |t|
			t.string :offense
			t.string :severity
			t.string :date_of_crime
			t.boolean :completed_crime
		end
	end

end