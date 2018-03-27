class CreateLocationsTable < ActiveRecord::Migration[5.1]

	def change
		create_table :locations do |t|
			t.string :name
			t.string :scene_of_crime
			t.string :in_or_out
		end
	end

end