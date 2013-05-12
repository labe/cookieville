class Player < ActiveRecord::Base
	attr_accessor :viewer, :player, :baker, :ovens

	validates :username, :uniqueness => { :case_sensitive => false }
	validates :username, :format => { :with => /\A\w{2,}\z/, :message => "Usernames may only be one word long and must be at least 2 characters long."}

	def run!
		@viewer = Viewer.new
		@bakery = Bakery.new(:name => "CookieVille")
		reset_view
		viewer.print_greeting
		player_setup(gets.chomp)		
		main_menu
		viewer.print_goodbye
	end

	def player_setup(username)
		set_player_id(username)
		set_all_bakery_ids(player[:id])
	end

	def set_player_id(username)
		if Player.where(:username => username).any?
			@player = Player.where(:username => username).first
			viewer.welcome_back_player(player)
			sleep(1)
		elsif username == ""
			create_new_player
		else
			viewer.print_player_not_found
			player_not_found
		end
	end

	def player_not_found
		username = gets.chomp
		until Player.where(:username => username).any? || username == ""
			viewer.print_player_not_found
			username = gets.chomp
		end
		username == "" ? create_new_player : @player = Player.where(:username => username).first
	end

	def create_new_player
		viewer.ask_for_username
		username = gets.chomp
		while Player.where(:username => username).any?
			viewer.print_username_taken
			username = gets.chomp
		end
			@player = Player.create!(:username => username)
	end

	def set_all_bakery_ids(player_id)
		if !Bakery.where(:player_id => player_id).any?
			new_player_setup(player_id)
		else				
			@bakery = Bakery.where(:player_id => player_id).first
			@baker = Baker.where(:bakery_id => @bakery[:id]).first
			@ovens = Oven.where(:bakery_id => @bakery[:id])
		end
	end

	def new_player_setup(player_id)
		bakery_setup(player_id)
		baker_setup
		oven_setup
	end

	def bakery_setup(player_id)
		viewer.ask_bakery_name(player[:username])
		@bakery = Bakery.create!(:name => gets.chomp, :player_id => player_id)
	end

	def baker_setup
		viewer.ask_baker_name(@bakery[:name])
		@baker = Baker.create!(:name => gets.chomp, :bakery_id => @bakery[:id])
	end

	def oven_setup
		@ovens = []
		ovens << Oven.create!(:bakery_id => @bakery[:id], :model_id => 1)
		ovens << Oven.create!(:bakery_id => @bakery[:id], :model_id => 2)
		viewer.print_oven_info
		press_any_key_to_continue
	end

	def main_menu
		reset_view
		viewer.print_main_menu
		command = gets.chomp.upcase
		case command
		when "1"
			reset_view
			viewer.print_all_recipe_names
			viewer.print_view_recipe_options
			print_recipes(gets.chomp)
		when "2"
			reset_view
			viewer.print_all_recipe_names
			viewer.print_make_recipe_options
			make_cookies(gets.chomp) 
		when "Q" then return
		else 
			input_error
			main_menu
		end
	end

	def print_recipes(recipe_id)
		if recipe_id == ""
			reset_view
			Recipe.all.each { |recipe| viewer.print_recipe(recipe.format) }
		elsif Recipe.where(:id => recipe_id).any?
			reset_view
			viewer.print_recipe(Recipe.where(:id => recipe_id).first.format)
		else 
			input_error
			print_recipes(gets.chomp)
		end
		press_any_key_to_continue
	end

	def make_cookies(recipe_id)
		if Recipe.where(:id => recipe_id).any?
			baker.make_cookies(recipe_id)
			viewer.print_success_batch_made(Recipe.where(:id => recipe_id).first[:name])
		elsif recipe_id == ""
			main_menu
		else
			input_error
			make_cookies(gets.chomp.upcase)
		end
		press_any_key_to_continue
	end


	def input_error
		viewer.print_error
		sleep(0.2)
	end

	def reset_view
		sleep(0.8)
		viewer.clear_screen!
		viewer.move_to_home!
		viewer.print_bakery_header(@bakery[:name])
	end

	def press_any_key_to_continue
		viewer.press_any_key
		gets.chomp
		main_menu
	end
end

# class Player
# 	attr_reader :viewer
# 	attr_accessor :baker

# 	def initialize
# 		@viewer = Viewer.new
# 		@baker = nil
# 	end

# 	def run!
# 		check_all_cookies
# 		baker = establish_baker(1)						# prettier way of doing this?
# 		p baker.put_cookies_in_oven(9,1)			# "oven is not ready!" -> need to set oven temp
# 		Oven.bake!(12)												# currently does nothing
# 		check_cookies_in_oven_status					# also does nothing because no cookies in any oven
# 		print_stats(baker)
# 		print_recipes
# 	end

# 	def establish_baker(baker_id)
# 		Baker.where(:id => baker_id).first
# 	end

# 	def check_cookies_in_oven_status
# 		Cookie.where(:is_in_oven => true).each do |cookie|
# 			puts "Batch \##{cookie[:id]}. " + Recipe.where(:id => cookie[:recipe_id]).first[:name] + ": " + Status.where(:id => cookie[:status_id]).first[:name]
# 		end
# 	end

# 	def print_recipes
# 		Recipe.all.each { |recipe| print recipe.format }
# 	end

# 	def print_stats(baker)
# 		print baker.get_stats
# 	end

# 	def check_all_cookies
# 		Cookie.all.each do |cookie|
# 			puts "Batch \##{cookie[:id]}. " + Recipe.where(:id => cookie[:recipe_id]).first[:name] + ": " + Status.where(:id => cookie[:status_id]).first[:name]
# 		end
# 	end

# end

