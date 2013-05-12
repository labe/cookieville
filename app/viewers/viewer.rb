class Viewer

WIDTH = 50
LINE = "-" * WIDTH

GREETING = %Q(
Welcome to CookieVille!

If you've played before, please enter your username.

If you're new to CookieVille, just press [ENTER] to get started!
> )

MAIN_MENU =
"[1] View all recipes" + "\n" +					# done
"[2] Make cookie recipe" + "\n" +				# done
"[3] Check cookie status" + "\n" +			
"[4] Put cookies in oven" + "\n" +
"[5] Remove cookies from oven" + "\n" +
"[6] Set oven temp" + "\n" +
"[7] Get bakery stats" + "\n" +
 "\n" +
"[Q] Quit game"  + "\n"

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
		puts LINE
		puts LINE
		puts (bakery_name.center(WIDTH))
		puts LINE
		puts LINE + "\n\n"
	end

	def print_main_menu
		print MAIN_MENU
		print PROMPT
	end

	def print_all_recipe_names
		print Recipe.all_names_with_id
	end

	def print_view_recipe_options
		print "Which recipe would you like to view?\n"
		print "Enter the recipe number, or press [ENTER] to view all: "
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

	def press_any_key
		print "Press [ENTER] to return to the main menu"
	end

	def print_error
		print "That is not a valid option. Try again?\n"
		print "> "
	end

	def print_goodbye
		puts "Thanks for playing. Come visit CookieVille again soon!"
	end
end