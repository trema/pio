begin
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
rescue LoadError
  task 'coveralls:push' do
    $stderr.puts 'Coveralls is disabled'
  end
end
