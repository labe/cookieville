class Player
	attr_reader :viewer
	attr_accessor :baker

	def initialize
		@viewer = Viewer.new
		@baker = nil
	end

	def run!
		check_all_cookies
		baker = establish_baker(1)						# prettier way of doing this?
		p baker.put_cookies_in_oven(9,1)			# "oven is not ready!" -> need to set oven temp
		Oven.bake!(12)												# currently does nothing
		check_cookies_in_oven_status					# also does nothing because no cookies in any oven
		print_stats(baker)
		print_recipes
	end

	def establish_baker(baker_id)
		Baker.where(:id => baker_id).first
	end

	def check_cookies_in_oven_status
		Cookie.where(:is_in_oven => true).each do |cookie|
			puts "Batch \##{cookie[:id]}. " + Recipe.where(:id => cookie[:recipe_id]).first[:name] + ": " + Status.where(:id => cookie[:status_id]).first[:name]
		end
	end

	def print_recipes
		Recipe.all.each { |recipe| print recipe.format }
	end

	def print_stats(baker)
		print baker.get_stats
	end

	def check_all_cookies
		Cookie.all.each do |cookie|
			puts "Batch \##{cookie[:id]}. " + Recipe.where(:id => cookie[:recipe_id]).first[:name] + ": " + Status.where(:id => cookie[:status_id]).first[:name]
		end
	end

end

