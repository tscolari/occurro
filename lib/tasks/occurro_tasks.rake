# desc "Explaining what the task does"
# task :occurro do
#   # Task goes here
# end

namespace :occurro do
  desc "Runs the daily rotation in the counters table"
  task :daily_rotation => :environment do
    require 'occurro/tasks' 
    Occurro::Tasks.daily_update
  end

  desc "Runs the weekly rotation in the counters table"
  task :weekly_rotation => :environment do
    require 'occurro/tasks' 
    Occurro::Tasks.weekly_update
  end

  desc "Runs the monthly rotation in the counters table"
  task :monthly_rotation => :environment do
    require 'occurro/tasks' 
    Occurro::Tasks.montly_update
  end
end
