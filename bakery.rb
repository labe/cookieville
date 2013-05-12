require_relative 'config/application'

Player.new.run!

# p Recipe.last.id


# # p Baker.new.put_cookies_in_oven(9,1)

# # p Oven.where(1).first.is_empty?






# p Cookie.where('status_id = 1 AND baker_id = 1').count
# print Baker.where('id = 1').first.get_stats


# # count number of cookie batches that are either uncooked or burned
# p Cookie.where('status_id = 1 OR status_id = 4').count
# # count number of batches that are currently in the oven
# p Cookie.where(:is_in_oven => true).count
# # count number of batches currently in oven 1
# p Cookie.where(:oven_id => 1).count
# # checks whether oven 1 is full or not