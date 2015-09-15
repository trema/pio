# rubocop:disable LineLength
When(/^I try to parse a file named "(.*?\.raw)" with "(.*?)" class$/) do |path, klass|
  full_path = File.expand_path(File.join(__dir__, '..', path))
  raw_data = IO.read(full_path)
  parser_klass = Pio.const_get(klass)
  begin
    @result = parser_klass.read(raw_data)
  rescue
    @last_error = $ERROR_INFO
  end
end
# rubocop:enable LineLength

# rubocop:disable LineLength
When(/^I try to parse a file named "(.*?\.pcap)" with "(.*?)" class$/) do |path, klass|
  full_path = File.expand_path(File.join(__dir__, '..', path))
  pcap = Pio::Pcap::Frame.read(IO.read(full_path))
  parser_klass = Pio.const_get(klass)
  begin
    @result = pcap.records.each_with_object([]) do |each, result|
      result << parser_klass.read(each.data)
    end
  rescue
    @last_error = $ERROR_INFO
  end
end
# rubocop:enable LineLength

Then(/^it should finish successfully$/) do
  expect(@last_error).to be_nil
end

Then(/^it should fail with "([^"]*)", "([^"]*)"$/) do |error, message|
  expect(@last_error.class.to_s).to eq(error)
  expect(@last_error.message).to eq(message)
end

When(/^I create an exact match from "(.*?)"$/) do |path|
  full_path = File.expand_path(File.join(__dir__, '..', path))
  @result = Pio::ExactMatch.new(Pio::PacketIn.read(IO.read(full_path)))
end

Then(/^the message should be a "([^"]*)"$/) do |expected_klass|
  expect(@result.class.to_s).to eq(expected_klass)
end

Then(/^the packet has the following fields and values:$/) do |table|
  table.hashes.each do |each|
    output = @result.instance_eval("self.#{each['field']}")
    if /^:/ =~ output.inspect
      expect(output.inspect).to eq(each['value'])
    else
      expect(output.to_s).to eq(each['value'])
    end
  end
end

Then(/^the message has the following fields and values:$/) do |table|
  step 'the packet has the following fields and values:', table
end

Then(/^the action has the following fields and values:$/) do |table|
  step 'the packet has the following fields and values:', table
end

# rubocop:disable LineLength
Then(/^the message \#(\d+) have the following fields and values:$/) do |index, table|
  table.hashes.each do |each|
    output = each['field'].split('.').inject(@result[index.to_i - 1]) do |memo, method|
      memo.__send__(method)
    end
    expect(output.to_s).to eq(each['value'])
  end
end
# rubocop:enable LineLength
