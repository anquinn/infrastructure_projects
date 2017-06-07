set :output, "log/cron_log.log"
set :bundle_command, "/home/deploy/.rbenv/shims/bundle exec"

# update project list everyday at 2am
every :day, :at => '2:00am' do
  rbenv_rake "db:update"
end