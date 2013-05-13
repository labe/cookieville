class Baker < ActiveRecord::Base

	def make_cookies(recipe_id)
		Cookie.create!(:recipe_id => recipe_id, :baker_id => self.id)
	end

	def put_cookies_in_oven(cookie_id, oven_id)
		return "\nThat oven is full!\n" if Oven.where(:id => oven_id).first.is_full? == true
		return "\nThat oven is not set to the right temperature for those cookies!\n" if Oven.where(:id => oven_id).first[:temp] != Recipe.where(:id => Cookie.where(:id => cookie_id).first[:recipe_id]).first[:bake_temp]
		Cookie.update(cookie_id, :is_in_oven => true, :oven_id => oven_id)
		"\nHooray, your cookies are in the oven!\n"
	end

	def remove_cookies_from_oven(batch_id)
		cookies = Cookie.where(:id => batch_id).first
		Cookie.update(batch_id, :is_in_oven => false, :oven_id => nil)
		"\nYour #{Recipe.where(:id => cookies[:recipe_id]).first[:name]} cookies have been taken out of the oven. They are #{Status.where(:id => cookies[:status_id]).first[:name]}!\n"
	end

	def set_oven_temp(oven_id, temp)
		Oven.update(oven_id, :temp => temp)
		"Oven temperature has been set!\n\n"
	end

	def get_stats
		"Baker name: #{self[:name]}\n" +
		"Batches created: #{Cookie.where(:baker_id => self[:id]).count}\n" +
		"Batches successfully baked: #{Cookie.where(:baker_id => self[:id], :status_id => 3).count}\n\n"
	end

end