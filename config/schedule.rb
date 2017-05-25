set :chronic_options, :hours24 => true

# update project list everyday at 2am
every 1.day, :at => '2:00' do
  rake "db:update"
end