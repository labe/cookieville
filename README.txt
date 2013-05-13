---------------------------
C O O K I E V I L L E ! ! !
---------------------------

I. What what?!
	A. This is a single-player-interactive virtual cookie bakery.
		1. Where you, as the player, can make cookies.
			a. Different kinds of cookies!
			b. and "making" incorporates "baking"!
				i. You can also burn your cookies if you aren't paying attention.
					aa. or if you're just into burned cookies for some reason.
				ii. conversely you can also deliberately underbake your cookies.
				iii. or not bake them at all, if you're a raw cookie-dough fan
					aa. (ugh)
		2. Only one player can play at a time
			a. i.e., no networking support. yet?
		3. But the game supports multiple (lots of multiple!) players
		4. AND IT SAVES EACH PLAYER'S DATA.
			a. so if you made 10 batches of burned lemon cookies last time, they'll
				 still be in your bakery the next time you come back to the game.


II. TELL ME MORE TELL ME MORE
	A. Whoa greased lightning, you're burning up the quarter-mile 
		1. (with your caps lock)
		2. AND I LIKE IT
	B. Okay but seriously
	C. GETTING STARTED
		1. in your REPL, navigate to the application root folder
			a. by default, it should be named "cookieville"
		2. from the command line, execute:
			a. $ gem install activerecord
			b. $ rake db:drop && rake db:create && rake db:migrate && rake db:seed
		3. to run the program:
			a. $ ruby cookieville.rb


III. This outline format is somewhat muddled, kid
	A. Truth.



DIRECTIONS:

1. Fork the cookieville repo
2. Clone your forked copy to your local machine
3. In your REPL, navigate to wherever you cloned the repo
4. Inside the root directory (should be called "cookieville"), from the REPL, type:
	$ gem install activerecord
	$ rake db:drop && rake db:create && rake db:migrate && rake db:seed
	$ ruby cookieville.rb 