class Cookie < ActiveRecord::Base
	def self.update_state
		self.all.each do |cookie|
			time = Recipe.where(:id => cookie[:recipe_id]).first[:bake_time]
			case cookie[:time_in_oven]
			when 0...(0.7 * time) then cookie[:status_id] = 1
			when (0.7 * time)...time then cookie[:status_id] = 2
			when time..(time+1) then cookie[:status_id] = 3
			else cookie[:status_id] = 4
			end
			cookie.save
		end
	end

	def self.all_player_cookies_with_status_and_id(baker_id)
		all_player_cookies = ""
		i = 1
		self.where(:baker_id => baker_id).each do |cookie|
			if cookie[:is_in_oven]
				oven_id = Oven.where(:id => cookie[:oven_id]).first[:model_id]
				oven_name = OvenModel.where(:id => oven_id).first[:name]
				oven_status = "in #{oven_name} (Oven \##{oven_id})"
			else 
				oven_status = "not in oven"
			end
			status = Status.where(:id => cookie[:status_id]).first[:name]
			name = Recipe.where(:id => cookie[:recipe_id]).first[:name]
			all_player_cookies << "#{i}. #{name.capitalize}\n" + 
													  "Status: Currently #{oven_status}. Cookies are #{status}.\n" +
													  "Time in oven: #{cookie[:time_in_oven]}\n\n"
			i += 1
		end
		all_player_cookies
	end

	def self.convert_id(cookie_id, baker_id)
		self.where(:baker_id => baker_id).each_with_index do |cookie, i|
			return cookie[:id] if cookie_id == i + 1
		end
	end
end