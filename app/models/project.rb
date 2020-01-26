class Project < ActiveRecord::Base
	belongs_to :program, counter_cache: true
	belongs_to :category, counter_cache: true
	belongs_to :location, counter_cache: true
	belongs_to :region, counter_cache: true
end
