class Oven < ActiveRecord::Base
	belongs_to	:bakery
	belongs_to	:oven_model

	def self.bake!(time = 1)
		Cookie.where(:is_in_oven => true).each do |cookie|
			Cookie.update(cookie.id, :time_in_oven => cookie.time_in_oven + time)
		end
		Cookie.update_state
	end

	def is_full?
		Cookie.where(:oven_id => self.id).count == OvenModel.where(:id => self.model_id).first[:max_capacity]
	end
end