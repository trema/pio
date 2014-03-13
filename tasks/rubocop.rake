begin
  require 'rubocop/rake_task'
  Rubocop::RakeTask.new do |task|
    task.patterns = %w(lib/**/*.rb
                       spec/**/*.rb
                       Gemfile
                       Guardfile
                       pio.gemspec)
  end
rescue LoadError
  task :rubocop do
    $stderr.puts 'Rubocop is disabled'
  end
end
