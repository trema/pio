Given(/^I switch the Pio::OpenFlow version to "([^"]*)"$/) do |version|
  Pio::OpenFlow.switch_version version.to_sym
end

When(/^I get the OpenFlow version string$/) do
  @version = Pio::OpenFlow.version
end

When(/^the version string should be "([^"]*)"$/) do |expected_version_string|
  expect(@version).to eq(expected_version_string)
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
