class Bakery < ActiveRecord::Base
	has_many	:ovens
	has_many 	:oven_models, :through => :ovens
end