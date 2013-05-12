# populates cookie statuses table:

["doughy", "almost done", "ready", "burned"].each do |status|
	Status.create!(:name => status)
end

# populates cookie recipes table

["chocolate chip", "peanut butter", "oatmeal raisin", "snickerdoodle", "lemon"].each do |name|
	Recipe.create!(:name => name, :bake_temp => [325,350,375].sample, :bake_time => [12,14,16].sample, :yield => [12, 18,24].sample)
end

# makes 10 arbitrary batches of cookie dough and randomly assigns them a baker_id

10.times do
	Cookie.create!(:recipe_id => [1,2,3,4,5].sample, :baker_id => [1,2].sample)
end

# makes 2 bakers

Baker.create!(:name => "pickles", :bakery_id => 1)
Baker.create!(:name => "moogle", :bakery_id => 1)

# makes 2 ovens

Oven.create!(:name => "bertha", :bakery_id => 1)
Oven.create!(:name => "rosie", :bakery_id => 1)