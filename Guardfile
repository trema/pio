# A sample Guardfile
# More info at https://github.com/guard/guard#readme


guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end


guard :rspec do
  watch(%r{^spec/pio/.+_spec\.rb$})
  watch(%r{^lib/pio/(.+)\.rb$})     { |m| "spec/lib/pio/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end
