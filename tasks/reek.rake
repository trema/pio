begin
  require 'reek/rake/task'
  Reek::Rake::Task.new do |t|
    t.config_file = File.join(__dir__, '..', '.reek')
    t.fail_on_error = false
    t.verbose = false
  end
rescue LoadError
  task :reek do
    $stderr.puts 'Reek is disabled'
  end
end
