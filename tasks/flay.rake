begin
  require 'rake/tasklib'
  require 'flay'
  require 'flay_task'
  FlayTask.new do |t|
    t.dirs = FileList['lib/**/*.rb'].map do |each|
      each[%r{[^/]+}]
    end.uniq
    t.threshold = FLAY_THRESHOLD if Kernel.const_defined?(:FLAY_THRESHOLD)
    t.verbose = true
  end
rescue LoadError
  task :flay do
    $stderr.puts 'Flay is disabled'
  end
end
