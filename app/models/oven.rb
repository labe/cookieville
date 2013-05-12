class Oven < ActiveRecord::Base
	belongs_to	:bakery
	belongs_to	:oven_model

	def self.bake!(baker, time = 1)
		return "You don't have any cookies in the oven!\n" if Cookie.where(:baker_id => baker[:id], :is_in_oven => true).none?
		Cookie.where(:baker_id => baker[:id], :is_in_oven => true).each do |cookie|
			Cookie.update(cookie.id, :time_in_oven => cookie.time_in_oven + time)
		end
		Cookie.update_state
		time == 1 ? time_string = "#{time} minute" : time_string = "#{time} minutes"
		"You have baked your cookies for #{time_string}!\n"
	end

	def is_full?
		Cookie.where(:oven_id => self.id).count == OvenModel.where(:id => self.model_id).first[:max_capacity]
	end

	def is_empty?
		Cookie.where(:oven_id => self.id).none?
	end

	def self.convert_id(oven_model_id, bakery_id)
		self.where(:model_id => oven_model_id, :bakery_id => bakery_id).first[:id]
	end

	def self.all_stats(bakery_id)
		i = 1
		oven_stats = ""
		Oven.where(:bakery_id => bakery_id).each do |oven|
			name = OvenModel.where(:id => oven[:model_id]).first[:name]
			max_capacity = OvenModel.where(:id => oven[:model_id]).first[:max_capacity]
			count = Cookie.where(:oven_id => oven[:id]).count
			count == 1 ? count_string = "#{count} batch" : count_string = "#{count} batches"
			oven_stats << "Oven \##{i}: #{name}\n" + 
									  "Current temperature: #{oven[:temp]}\n" +
									  "Contains: #{count_string} of cookies (Maximum capacity = #{max_capacity})\n"
			if count > 0
				Cookie.where(:oven_id => oven[:id]).each do |cookie|
					batch_name = Recipe.where(:id => cookie[:recipe_id]).first[:name]
					batch_status = Status.where(:id => cookie[:status_id]).first[:name]
					oven_stats << "In this oven: #{batch_name}\n" +
												"(inserted #{cookie[:time_in_oven]} minutes ago, cookies are #{batch_status})\n"
				end
			oven_stats << "\n"
			end
			i += 1
		end
		oven_stats
	end
end