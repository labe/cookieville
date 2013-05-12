class Recipe < ActiveRecord::Base
	def format
		"Recipe name: #{self[:name].capitalize}\n" +
		"Directions: Bake at #{self[:bake_temp]}F for #{self[:bake_time]} minutes.\n" +
		"Makes: #{self[:yield]} cookies.\n\n"
	end
end