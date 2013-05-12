class Cookie < ActiveRecord::Base
	def self.update_state
		self.all.each do |cookie|
			time = Recipe.where(:id => cookie[:recipe_id]).first[:bake_time]
			case cookie[:time_in_oven]
			when 0...(0.7 * time) then cookie[:status_id] = 1
			when (0.7 * time)...time then cookie[:status_id] = 2
			when time..(time1) then cookie[:status_id] = 3
			else cookie[:status_id] = 4
			end
			cookie.save
		end
	end
end