job_type :rbenv_rake, %Q{export PATH=/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && :environment_variable=:environment :bundle_command rake :task --silent :output }

# update project list everyday at 2am
# every :day, :at => '2:00am' do
#   rbenv_rake "db:update"
# end

every 5.minutes + 10.seconds do
  rbenv_rake "db:update"
end