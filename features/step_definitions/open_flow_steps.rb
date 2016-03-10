Given(/^I switch the Pio::OpenFlow version to "([^"]*)"$/) do |version|
  Pio::OpenFlow.version = version
end

When(/^I get the OpenFlow version string$/) do
  @version = Pio::OpenFlow.version.to_s
end

Then(/^the version string should be "([^"]*)"$/) do |expected_version_string|
  expect(@version).to eq(expected_version_string)
end

When(/^I create a packet with:$/) do |ruby_code|
  @result = Pio.module_eval(ruby_code)
end

When(/^I create an OpenFlow message with:$/) do |ruby_code|
  step 'I create a packet with:', ruby_code
end

When(/^I create an OpenFlow action with:$/) do |ruby_code|
  step 'I create a packet with:', ruby_code
end

When(/^I create an OpenFlow instruction with:$/) do |ruby_code|
  step 'I create a packet with:', ruby_code
end

# rubocop:disable LineLength
Then(/^the following each raw file should be parsed into its corresponding object using OpenFlow\.read$/) do |table|
  table.hashes.each do |each|
    step %(I parse a file named "#{each['raw file']}" with "Pio::OpenFlow" class)
    step %(the message should be a "#{each['result object']}")
  end
end
# rubocop:enable LineLength
