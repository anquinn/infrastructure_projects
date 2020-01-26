class Region < ActiveRecord::Base
	has_many :projects, dependent: :destroy
	has_many :locations

	REGION_CHOICES = [
	    ['Alberta', 'ab'],
	    ['British Columbia', 'bc'],
	    ['Manitoba', 'mb'],
	    ['New Brunswick', 'nb'],
	    ['Newfoundland and Labrador', 'nl'],
	    ['Northwest Territories', 'nt'],
	    ['Nova Scotia', 'ns'],
	    ['Nunavut', 'nu'],
	    ['Ontario', 'on'],
	    ['Prince Edward Island', 'pe'],
	    ['Quebec', 'qc'],
	    ['Saskatchewan', 'sk'],
	    ['Yukon', 'ty']
	]

  def region_display
    Hash[REGION_CHOICES.map { |s| [s[1], s[0]] }][self.code]
  end
end
