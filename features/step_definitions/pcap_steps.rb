# encoding: utf-8

Given(/^a pcap file "(.*?)"$/) do |pcap|
  @pcap = File.join(File.dirname(__FILE__), '..', 'pcap', pcap)
end

When(/^I try to parse the pcap file with "(.*?)" class$/) do |parser|
  File.open(@pcap) do |file|
    pcap = Pcap::Frame.read(file)
    pcap.records.each do |each|
      Pio.const_get(parser).__send__ :read, each.data
    end
  end
end

Then(/^it should finish successfully$/) do
  # Noop.
end
