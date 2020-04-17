require 'pry'

task :paralelismo do ||
  # profiles = "#{args[:env]} #{args[:profiles]} -p parallel"

  tags_to_run = ENV['TAGS']
  browsers = ENV['QTD_BROWSERS']
  command = "bundle exec parallel_cucumber features/ -n #{browsers} -o '--tags  #{tags_to_run}'"
  puts command
  system command
end
