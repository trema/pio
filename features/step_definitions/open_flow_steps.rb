Given(/^I switch the Pio::OpenFlow version to "([^"]*)"$/) do |version|
  Pio::OpenFlow.switch_version version.to_sym
end

When(/^I get the OpenFlow version string$/) do
  @version = Pio::OpenFlow.version
end

Then(/^the version string should be "([^"]*)"$/) do |expected_version_string|
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

# rubocop:disable LineLength
Then(/^the following each raw file should be parsed into its corresponding object using OpenFlow\.read$/) do |table|
  table.hashes.each do |each|
    step %(I try to parse a file named "#{each['raw file']}" with "OpenFlow" class)
    step 'it should finish successfully'
    step %(the message should be a "#{each['result object']}")
  end
end
# rubocop:enable LineLength
