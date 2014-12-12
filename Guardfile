guard :bundler do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end

guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^spec/pio/.+_spec\.rb$})
  watch(%r{^lib/pio/(.+)\.rb$})     { |m| "spec/pio/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :rubocop do
  watch(/.+\.rb$/)
  watch(/(?:.+\/)?\.rubocop\.yml$/) { |m| File.dirname(m[0]) }
end

guard :cucumber, cli: '--profile default' do
  watch(/^features\/.+\.feature$/)
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^features/step_definitions/(.+)_steps\.rb$}) do |m|
    Dir[File.join("**/#{m[1]}.feature")][0] || 'features'
  end
end
