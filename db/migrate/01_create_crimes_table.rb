class CreateCrimesTable < ActiveRecord::Migration[5.1]

	def change
		create_table :crimes do |t|
			t.string :offense
			t.string :type
			t.date :date_of_crime
			t.boolean :completed_crime
			t.integer :complaint_num
		end
	end

end