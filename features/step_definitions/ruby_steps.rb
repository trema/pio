When(/^I eval the following Ruby code:$/) do |ruby_code|
  @result = Pio.module_eval(ruby_code)
end

Then(/^the result of eval should be:$/) do |expected|
  expect(@result.to_s).to eq expected
end
