class Player < ActiveRecord::Base
	attr_accessor :viewer, :player, :baker, :ovens, :bakery

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
			@baker = Baker.where(:bakery_id => bakery[:id]).first
			@ovens = Oven.where(:bakery_id => bakery[:id])
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
		viewer.ask_baker_name(bakery[:name])
		@baker = Baker.create!(:name => gets.chomp, :bakery_id => bakery[:id])
	end

	def oven_setup
		@ovens = []
		ovens << Oven.create!(:bakery_id => bakery[:id], :model_id => 1)
		ovens << Oven.create!(:bakery_id => bakery[:id], :model_id => 2)
		viewer.print_oven_info
		press_any_key_to_continue
	end

	def main_menu
		reset_view
		viewer.print_main_menu
		command = gets.chomp.upcase
		case command
		when "1" then view_recipe_options_menu
		when "2" then make_recipe_options_menu
		when "3" then check_cookie_status_menu
		when "4" then set_oven_temp
		when "5" then put_cookies_in_oven
		when "6" then bake_cookies
		when "Q" then return
		else 
			input_error
			main_menu
		end
	end

	def view_recipe_options_menu
		reset_view
		viewer.print_all_recipe_names
		viewer.print_view_options("recipe")
		print_recipes(gets.chomp)
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

	def make_recipe_options_menu
		reset_view
		viewer.print_all_recipe_names
		viewer.print_make_recipe_options
		make_cookies(gets.chomp) 
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

	def check_cookie_status_menu
		reset_view
		viewer.print_all_player_cookies(baker[:id])
	  press_any_key_to_continue
	end

	def set_oven_temp
		reset_view
		viewer.print_oven_status(bakery[:id])
		viewer.ask_for_oven_id
		if gets.chomp == ""
			input_error
		else 
			oven_id = Oven.convert_id(gets.chomp.to_i, bakery[:id])
			viewer.ask_for_oven_temp
			oven_temp = gets.chomp.to_i
			viewer.print_set_oven_temp_results(baker, oven_id, oven_temp)
		end
		press_any_key_to_continue
	end

	def put_cookies_in_oven
		reset_view
		viewer.print_all_player_cookies(baker[:id])
		viewer.ask_for_cookie_batch_id
		batch_id = Cookie.convert_id(gets.chomp.to_i, baker[:id])
		reset_view
		viewer.print_oven_status(bakery[:id])
		viewer.ask_for_oven_id
		oven_id = Oven.convert_id(gets.chomp.to_i, bakery[:id])
		viewer.print_cookies_in_oven_attempt_results(batch_id, oven_id, baker)
		press_any_key_to_continue
	end

	def bake_cookies
		viewer.ask_for_bake_time
		bake_time = gets.chomp
		bake_time == "" ? viewer.print_bake_attempt_results(baker, 1) : viewer.print_bake_attempt_results(baker, bake_time.to_i)
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
		viewer.print_bakery_header(bakery[:name])
	end

	def press_any_key_to_continue
		viewer.press_any_key
		gets.chomp
		main_menu
	end
end