class Baker < ActiveRecord::Base

	def make_cookies(name_id)
		Cookie.create!(:name_id => name_id, :baker_id => self.id)
	end

	def put_cookies_in_oven(batch_id, oven_id)
		return "Those cookies are already in the oven" if Cookie.where(:id => batch_id).first.is_in_oven == true
		return "That oven is full!" if Oven.where(:id => oven_id).first.is_empty? == false
		return "Oven is not ready!" if Oven.where(:id => oven_id).first[:temp] != Recipe.where(:id => Cookie.where(:id => batch_id).first[:recipe_id]).first[:bake_temp]
		Cookie.update(batch_id, :is_in_oven => true, :oven_id => oven_id)
	end

	def remove_cookies_from_oven(batch_id)
		return "Those cookies are not in the oven" if Cookie.where(:id => batch_id).first.is_in_oven != true
		Cookie.update(batch_id, :is_in_oven => false, :oven_id => nil)
	end

	def set_oven_temp(oven_id, temp)
		Oven.update(oven_id, :temp => temp)
	end

	def get_stats
		"Baker name: #{self[:name]}\n" +
		"Batches created: #{Cookie.where(:baker_id => self[:id]).count}\n" +
		"Batches successfully baked: #{Cookie.where(:baker_id => self[:id], :status_id => 3).count}\n\n"
	end

end