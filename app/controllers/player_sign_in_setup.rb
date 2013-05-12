class Player < ActiveRecord::Base

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

end