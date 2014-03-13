require 'yaml'

def rubies
  travis_yml = File.join(__dir__, '..', '.travis.yml')
  YAML.load_file(travis_yml)['rvm'].uniq.sort
end

def gemfile_lock
  File.join File.dirname(__FILE__), 'Gemfile.lock'
end

desc 'Run tests against multiple rubies'
task :portability

rubies.each do |each|
  portability_task_name = "portability:#{each}"
  task :portability => portability_task_name

  desc "Run tests against Ruby#{each}"
  task portability_task_name do
    rm_f gemfile_lock
    sh "rvm #{each} exec bundle update"
    sh "rvm #{each} exec bundle install --without development"
    sh "rvm #{each} exec bundle exec rake"
  end
end
