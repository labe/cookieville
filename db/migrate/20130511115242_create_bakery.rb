class CreateBakery < ActiveRecord::Migration
	def change
		create_table 	:bakeries do |t|
			t.string		:name
			t.integer		:player_id
			t.timestamps
		end

		create_table 	:bakers do |t|
			t.string 		:name
			t.integer		:bakery_id
			t.timestamps
		end

		create_table 	:cookies do |t|
			t.integer		:recipe_id
			t.boolean		:is_in_oven, :default => false
			t.integer		:oven_id
			t.integer		:time_in_oven, :default => 0
			t.integer		:status_id, :default => 1
			t.integer		:baker_id
			t.timestamps
		end

		create_table 	:oven_models do |t|
			t.string		:name
			t.integer		:max_capacity
			t.timestamps
		end

		create_table	:ovens do |t|
			t.integer		:bakery_id
			t.integer		:model_id
			t.integer		:temp, :default => 0
			t.timestamps
		end

		create_table 	:statuses do |t|
			t.string		:name
			t.timestamps
		end

		create_table	:recipes do |t|
			t.string		:name
			t.integer		:bake_time
			t.integer		:bake_temp
			t.integer		:yield
			t.timestamps
		end

		create_table	:players do |t|
			t.string		:name
			t.string		:username
			t.string		:email
			t.integer		:high_score
			t.decimal		:bankroll
			t.timestamps
		end
	end
end