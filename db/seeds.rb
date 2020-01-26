require 'rake'

Rake::Task["db:update"].invoke

puts "Exiting"