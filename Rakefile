# -*- coding: utf-8 -*-
require 'bundler/gem_tasks'

task :default => :travis

task :travis => [:spec, :quality, 'coveralls:push']

desc 'Check for code quality'
task :quality => [:reek, :flog, :flay, :rubocop]

Dir.glob('tasks/*.rake').each { |each| import each }

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
