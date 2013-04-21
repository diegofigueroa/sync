# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

set :output, "/home/diego/projects/nospi/log/cron.log"

every 1.hours do
  runner "Synchronizer.perform_one"
end

every 5.hours do
  runner "Synchronizer.perform_five"
end

every 10.hours do
  runner "Synchronizer.perform_ten"
end

every 24.hours do
  runner "Synchronizer.perform_twentyfour"
end


# Learn more: http://github.com/javan/whenever
