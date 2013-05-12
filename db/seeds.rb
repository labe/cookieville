# populates cookie statuses table:

["doughy", "almost done", "ready", "burned"].each do |status|
	Status.create!(:name => status)
end

# populates cookie recipes table

["chocolate chip", "peanut butter", "oatmeal raisin", "snickerdoodle", "lemon"].each do |name|
	Recipe.create!(:name => name, :bake_temp => [325,350,375].sample, :bake_time => [12,14,16].sample, :yield => [12, 18,24].sample)
end

Recipe.create!(:name => "teddy grahams", :bake_temp => 300, :bake_time => 25, :yield => 60)

# makes 2 basic oven models (fancier models in the works!)

OvenModel.create!(:name => "bertha", :max_capacity => 2)
OvenModel.create!(:name => "rosie", :max_capacity => 2)


# makes 10 arbitrary batches of cookie dough and randomly assigns them a baker_id

# 10.times do
# 	Cookie.create!(:recipe_id => [1,2,3,4,5].sample, :baker_id => [1,2].sample)
# end
