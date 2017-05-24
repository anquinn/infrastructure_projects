class Location < ActiveRecord::Base
	has_many :projects, dependent: :destroy
	belongs_to :region
end
