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
	end

	def main_menu
		reset_view
		viewer.print_main_menu
		command = gets.chomp.upcase
		unless command == "Q"
			case command
			when "1" then view_recipe_options_menu
			when "2" then make_recipe_options_menu
			when "3" then check_cookie_status_menu
			when "4" then set_oven_temp
			when "5" then put_cookies_in_oven
			when "6" then bake_cookies
			when "7" then remove_cookies_from_oven
			else 
				input_error
				main_menu
			end
		end
		viewer.print_goodbye
		exit
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
		elsif Recipe.where(:id => recipe_id.to_i).any?
			reset_view
			viewer.print_recipe(Recipe.where(:id => recipe_id.to_i).first.format)
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
		model_id = gets.chomp
		if model_id == ""
			input_error
		elsif OvenModel.where(:id => model_id).any?
			oven_id = Oven.convert_id(model_id, bakery[:id])
			if !Oven.where(:id => oven_id).first.is_empty?
				viewer.print_cant_change_oven_temp
			else
				viewer.ask_for_oven_temp
				oven_temp = gets.chomp.to_i
				viewer.print_set_oven_temp_results(baker, oven_id, oven_temp)
			end
		else
			input_error
		end
		press_any_key_to_continue
	end

	def put_cookies_in_oven
		reset_view
		viewer.print_all_player_cookies(baker[:id])
		viewer.ask_for_cookie_batch_id("bake")
		batch_id = Cookie.convert_id(gets.chomp.to_i, baker[:id])
		if Cookie.where(:id => batch_id).first[:is_in_oven] == true
			viewer.print_cookies_already_in_oven
		else
			reset_view
			viewer.print_oven_status(bakery[:id])
			viewer.ask_for_oven_id
			oven_id = Oven.convert_id(gets.chomp.to_i, bakery[:id])
			viewer.print_cookies_in_oven_attempt_results(batch_id, oven_id, baker)
		end
		press_any_key_to_continue
	end

	def bake_cookies
		if Cookie.where(:baker_id => baker[:id], :is_in_oven => true).none?
			viewer.print_no_cookies_to_bake
		else
			viewer.ask_for_bake_time
			bake_time = gets.chomp
			bake_time == "" ? viewer.print_bake_attempt_results(baker, 1) : viewer.print_bake_attempt_results(baker, bake_time.to_i)
		end
		press_any_key_to_continue
	end

	def remove_cookies_from_oven
		reset_view
		viewer.print_all_player_cookies(baker[:id])
		viewer.ask_for_cookie_batch_id("take out")
		batch_id = Cookie.convert_id(gets.chomp.to_i, baker[:id])
		if Cookie.where(:id => batch_id).first[:is_in_oven] != true
			viewer.print_cookies_not_in_oven
		else
			viewer.print_remove_cookies_attempt_results(batch_id, baker)
		end
		press_any_key_to_continue
	end

	def input_error
		viewer.print_error
		press_any_key_to_continue
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