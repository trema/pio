# frozen_string_literal: true

When(/^I parse a file named "(.*?\.raw)" with "(.*?)" class$/) do |path, klass|
  raw_data = IO.read(expand_path("%/#{path}"))
  parser_klass = Pio.const_get(klass)
  @result = parser_klass.read(raw_data)
end

When(/^I parse a file named "(.*?\.pcap)" with "(.*?)" class$/) do |path, klass|
  pcap = Pio::Pcap::Frame.read(IO.read(expand_path("%/#{path}")))
  parser_klass = Pio.const_get(klass)
  @result = pcap.records.each_with_object([]) do |each, result|
    result << parser_klass.read(each.data)
  end
end

When(/^I create an exact match from "(.*?)"$/) do |path|
  raw_data = case File.extname(path)
             when '.raw'
               IO.read(expand_path("%/#{path}"))
             when '.rb'
               Pio.module_eval(IO.read(expand_path("%/#{path}")))
             else
               raise
             end
  @result = Pio::ExactMatch.new(Pio::PacketIn.read(raw_data))
end

Then(/^the message should be a "([^"]*)"$/) do |expected_klass|
  expect(@result.class.to_s).to eq(expected_klass)
end

Then(/^the packet has the following fields and values:$/) do |table|
  table.hashes.each do |each|
    output = @result.instance_eval("self.#{each['field']}")
    if /^:/.match?(output.inspect)
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
