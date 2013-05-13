# populates cookie statuses table:

["doughy", "almost done", "perfect", "burned"].each do |status|
	Status.create!(:name => status)
end

# populates cookie recipes table with randomly assigned details

["chocolate chip", "peanut butter", "oatmeal raisin", "snickerdoodle", "lemon"].each do |name|
	Recipe.create!(:name => name, :bake_temp => [325,350,375].sample, :bake_time => [12,14,16].sample, :yield => [12, 18,24].sample)
end

# adds teddy graham cookies to the recipe database (:

Recipe.create!(:name => "teddy grahams", :bake_temp => 300, :bake_time => 25, :yield => 60)

# makes 2 basic oven models (fancier models in the works!)

OvenModel.create!(:name => "Bertha", :max_capacity => 2)
OvenModel.create!(:name => "Rosie", :max_capacity => 2)