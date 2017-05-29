# update project list everyday at 2am
every :day, :at => '2:00am' do
  rake "db:update"
end