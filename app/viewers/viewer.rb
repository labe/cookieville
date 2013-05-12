class Viewer

WIDTH = 50
LINE = "-" * WIDTH

GREETING = 
%Q(Welcome to CookieVille!

If you've played before, please enter your username.

If you're new to CookieVille, just press [ENTER] to get started!
> )

MAIN_MENU =
"[1] View recipes" + "\n" +							# done
"[2] Make cookies" + "\n" +							# needs check for invalid user selection inputs
"[3] Check cookie status" + "\n" +			# done
"[4] Set oven temp" + "\n" +						# done
"[5] Put cookies in oven" + "\n" +			# done
"[6] Bake cookies!" + "\n" +						# done
"[7] Remove cookies from oven" + "\n" +	# done
"[8] Get bakery stats" + "\n" +					# bakery name, baker names and stats, oven names and stats
"[9] Settings and stuff" + "\n" + 			# help (how to play), change names, add info
 "\n" +
"[Q] Quit game"  + "\n"									# TOTALLY WORKS

PROMPT = %Q(
What would you like to do?
> )

	def move_to_home!
	  print "\e[H"
	end

	def clear_screen!
	  print "\e[2J"
	end

	def print_greeting
		print GREETING
	end

	def print_player_not_found
		print "Sorry, that username doesn't seem to exist. Try again?\n"
		print "(or press [ENTER] to create a new account)\n"
		print "> "
	end

	def ask_for_username
		puts "What username would you like?"
	end

	def print_username_taken
		print "Sorry, that username is already taken. Try something else?\n"
		print "> "
	end

	def welcome_back_player(player)
		puts "Welcome back, #{player.username}!"
	end

	def ask_bakery_name(username)
		puts "Greetings and felicitations, #{username}! Let's get you started."
		puts "What would you like to name your bakery?"
	end

	def ask_baker_name(bakery_name)
		puts "#{bakery_name} is an artisan operation, so for now, you'll start with just one baker."
		puts "What would you like to name your baker?"
	end

	def print_oven_info
		puts "Your bakery starts with two ovens, Bertha and Rosie.\n" +
				 "Each oven can hold two batches of cookies at a time.\n"
	end

	def print_bakery_header(bakery_name)
		2.times { puts LINE }
		puts (bakery_name.center(WIDTH))
		2.times { puts LINE }
		print "\n"
	end

	def print_main_menu
		print MAIN_MENU
		print PROMPT
	end

	def print_all_recipe_names
		print Recipe.all_names_with_id + "\n"
	end

	def print_view_options(item)
		print "Which #{item} would you like to view?\n"
		print "Enter the #{item} number, or press [ENTER] to view all: "
	end

	def print_make_recipe_options
		print "Which recipe would you like to make?\n"
		print "Enter the recipe number, or press [ENTER] to return to the main menu: "
	end

	def print_recipe(recipe)
		print recipe
	end

	def print_success_batch_made(recipe_name)
		print "You have created a batch of #{recipe_name} cookies!\n"
	end

	def print_all_player_cookies(baker_id)
		print Cookie.all_player_cookies_with_status_and_id(baker_id)
	end

	def print_oven_status(bakery_id)
		print Oven.all_stats(bakery_id)
	end

	def ask_for_oven_id
		print "Which oven would you like to choose?\n" +
					"Please enter the oven number: "
	end

	def ask_for_oven_temp
		print "\nTo what temperature would you like to set the oven?\n" +
					"> "
	end

	def print_set_oven_temp_results(baker, oven_id, oven_temp)
		print baker.set_oven_temp(oven_id, oven_temp)
	end

	def ask_for_cookie_batch_id
		print "Which cookies would you like to bake?\n" +
					"Please enter the cookie batch number: "
	end

	def print_cookies_in_oven_attempt_results(cookies_id, ovens_id, baker)
		print baker.put_cookies_in_oven(cookies_id, ovens_id)
	end

	def ask_for_bake_time
		print "Press [ENTER] to bake your cookies for 1 minute\n" +
					"or enter a specific amount of minutes to bake: "
	end

	def print_bake_attempt_results(baker, time)
		print Oven.bake!(baker, time)
	end

	def print_remove_cookies_attempt_results(batch_id, baker)
		print baker.remove_cookies_from_oven(batch_id)
	end

	def press_any_key
		print "Press [ENTER] to return to the main menu"
	end

	def print_error
		print "That is not a valid option.\n"
	end

	def print_goodbye
		puts "Thanks for playing. Come visit CookieVille again soon!"
	end
end