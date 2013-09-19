require "bundler/gem_tasks"
require "coveralls/rake/task"
require "flay"
require "flay_task"
require "flog"
require "rake/tasklib"
require "reek/rake/task"
require "rspec/core"
require "rspec/core/rake_task"
require "yaml"
require "yard"


$ruby_source = FileList[ "lib/**/*.rb" ]


task :default => :travis
task :travis => [ :spec, :quality, "coveralls:push" ]

desc "Check for code quality"
task :quality => [ :reek, :flog, :flay ]


Coveralls::RakeTask.new


RSpec::Core::RakeTask.new


Reek::Rake::Task.new do | t |
  t.fail_on_error = false
  t.verbose = false
  t.ruby_opts = [ "-rubygems" ]
  t.reek_opts = "--quiet"
  t.source_files = $ruby_source
end


desc "Analyze for code complexity"
task :flog do
  flog = Flog.new( :continue => true )
  flog.flog( *$ruby_source )
  threshold = 20

  bad_methods = flog.totals.select do | name, score |
    ( not ( /##{flog.no_method}$/=~ name ) ) and score > threshold
  end
  bad_methods.sort do | a, b |
    a[ 1 ] <=> b[ 1 ]
  end.reverse.each do | name, score |
    puts "%8.1f: %s" % [ score, name ]
  end
  unless bad_methods.empty?
    $stderr.puts "#{ bad_methods.size } methods have a flog complexity > #{ threshold }"
  end
end


FlayTask.new do | t |
  t.dirs = $ruby_source.collect do | each |
    each[ /[^\/]+/ ]
  end.uniq
  t.threshold = 0
  t.verbose = $trace
end


YARD::Rake::YardocTask.new do | t |
  t.options = [ "--no-private" ]
  t.options << "--debug" << "--verbose" if $trace
end


def travis_yml
  File.join File.dirname( __FILE__ ), ".travis.yml"
end


def rubies
  ( [ "1.8.7" ] + YAML.load_file( travis_yml )[ "rvm" ] ).uniq.sort
end


desc "Run tests against multiple rubies"
task :portability

rubies.each do | each |
  portability_task_name = "portability:#{ each }"
  task :portability => portability_task_name

  desc "Run tests against Ruby#{ each }"
  task portability_task_name do
    sh "rvm #{ each } exec bundle"
    sh "rvm #{ each } exec bundle exec rake"
  end
end


### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
