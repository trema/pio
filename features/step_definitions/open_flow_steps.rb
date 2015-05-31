Given(/^I use OpenFlow 1\.3$/) do
  require 'pio/open_flow13'
end

When(/^I try to create a packet with:$/) do |ruby_code|
  begin
    @result = Pio.module_eval(ruby_code)
  rescue
    @last_error = $ERROR_INFO
  end
end

When(/^I try to create an OpenFlow message with:$/) do |ruby_code|
  step 'I try to create a packet with:', ruby_code
end

When(/^I try to create an OpenFlow action with:$/) do |ruby_code|
  step 'I try to create a packet with:', ruby_code
end

When(/^I try to create an OpenFlow instruction with:$/) do |ruby_code|
  step 'I try to create a packet with:', ruby_code
end
