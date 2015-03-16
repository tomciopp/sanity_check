namespace :sanity do
  desc "Run the rails best practices command"
  task :best_practices => :environment do
    sh "rails_best_practices #{Rails.root}"
  end

  desc "Run the brakeman command"
  task :brakeman do
    sh "brakeman -q -z"
  end

  desc "Lint project using rubocop"
  task :rubocop do
    sh "rubocop -l"
  end

  desc "Run automated test suite"
  task :tests do
    Rake::Task["spec"].invoke if defined?(RSpec)
    Rake::Task["test"].invoke if defined?(Test::Unit)
  end

  desc "Run full sanity check"
  task :check do
    failing_tasks = []
    %W[sanity:tests traceroute sanity:rubocop sanity:brakeman sanity:best_practices].each do |task|
      sh("rake #{task}") do |exit_status|
        failing_tasks << task unless exit_status
      end
    end

    if failing_tasks.empty?
      puts "Your application's sanity check has passed!"
    else
      fail Exception, "An error occurred in #{failing_tasks.join(', ')}."
    end
  end
end