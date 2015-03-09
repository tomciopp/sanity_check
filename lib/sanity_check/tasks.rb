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

  desc "Run full sanity check"
  task :check do
    Rake::Task["spec"].invoke if defined?(RSpec)
    Rake::Task["test"].invoke if defined?(Test::Unit)
    Rake::Task["traceroute"].invoke
    Rake::Task["sanity:rubocop"].invoke
    Rake::Task["sanity:brakeman"].invoke
    Rake::Task["sanity:best_practices"].invoke
  end
end