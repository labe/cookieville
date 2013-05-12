class Baker < ActiveRecord::Base

	def make_cookies(recipe_id)
		Cookie.create!(:recipe_id => recipe_id, :baker_id => self.id)
	end

	def put_cookies_in_oven(cookie_id, oven_id)
		return "Those cookies are already in an oven!\n" if Cookie.where(:id => cookie_id).first[:is_in_oven] == true
		return "That oven is full!\n" if Oven.where(:id => oven_id).first.is_full? == true
		return "That oven is not set to the right temperature for those cookies!\n" if Oven.where(:id => oven_id).first[:temp] != Recipe.where(:id => Cookie.where(:id => cookie_id).first[:recipe_id]).first[:bake_temp]
		Cookie.update(cookie_id, :is_in_oven => true, :oven_id => oven_id)
		"Hooray, your cookies are in the oven!\n"
	end

	def remove_cookies_from_oven(batch_id)
		return "Those cookies are not in the oven" if Cookie.where(:id => batch_id).first.is_in_oven != true
		Cookie.update(batch_id, :is_in_oven => false, :oven_id => nil)
	end

	def set_oven_temp(oven_id, temp)
		return "You cannot change the temperature of this oven until it is empty!\n\n" if !Oven.where(:id => oven_id).first.is_empty?
		Oven.update(oven_id, :temp => temp)
		"Oven temperature has been set!\n\n"
	end

	def get_stats
		"Baker name: #{self[:name]}\n" +
		"Batches created: #{Cookie.where(:baker_id => self[:id]).count}\n" +
		"Batches successfully baked: #{Cookie.where(:baker_id => self[:id], :status_id => 3).count}\n\n"
	end

end