require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.options = ['--no-private']
  t.options << '--debug' << '--verbose' if verbose == true
end

desc 'List all undocumented objects'
task 'yard:list_undoc' do
  options = %w(stats --list-undoc)
  options << '--debug' << '--verbose' if verbose == true
  sh "yard #{options.join ' '}"
end
