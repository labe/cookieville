class Recipe < ActiveRecord::Base
	def format
		"Recipe name: #{self[:name].capitalize} cookies\n" +
		"Directions: Bake at #{self[:bake_temp]}F for #{self[:bake_time]} minutes.\n" +
		"Makes: #{self[:yield]} cookies.\n\n"
	end

	def self.all_names_with_id
		recipe_names = ""
		self.all.each do |recipe|
			recipe_names << "[#{recipe[:id]}] #{recipe[:name].capitalize}\n"
		end
		recipe_names
	end
end