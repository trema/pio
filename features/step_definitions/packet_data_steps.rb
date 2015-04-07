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

# rubocop:disable LineLength
When(/^I try to parse a file named "(.*?)\.raw" with "(.*?)" class$/) do |file_name, klass|
  path = File.expand_path(File.join(__dir__, '..', 'packet_data', file_name + '.raw'))
  raw_data = IO.read(path)
  parser_klass = Pio.const_get(klass)
  begin
    @result = parser_klass.read(raw_data)
  rescue
    @last_error = $ERROR_INFO
  end
end
# rubocop:enable LineLength

# rubocop:disable LineLength
When(/^I try to parse a file named "(.*?)\.pcap" with "(.*?)" class$/) do |file_name, klass|
  path = File.expand_path(File.join(__dir__, '..', 'packet_data', file_name + '.pcap'))
  pcap = Pio::Pcap::Frame.read(IO.read(path))
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

When(/^I create an exact match from "(.*?)"$/) do |file_name|
  path = File.expand_path(File.join(__dir__, '..', 'packet_data', file_name))
  @result = Pio::ExactMatch.new(Pio::PacketIn.read(IO.read(path)))
end

Then(/^the packet have the following fields and values:$/) do |table|
  table.hashes.each do |each|
    output = each['field'].split('.').inject(@result) do |memo, method|
      memo.__send__(method)
    end
    expect(output.to_s).to eq(each['value'])
  end
end

Then(/^the message have the following fields and values:$/) do |table|
  step 'the packet have the following fields and values:', table
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
