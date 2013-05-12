class OvenModel < ActiveRecord::Base
	has_many	:ovens
	has_many	:bakeries, :through => :ovens
end