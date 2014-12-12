Given(/^a packet data file "(.*?)"$/) do |name|
  path = File.expand_path(File.join(File.dirname(__FILE__),
                                    '..', 'packet_data', name))
  case File.extname(name)
  when '.raw'
    @raw = path
  when '.pcap'
    @pcap = path
  else
    fail "Unsupported file extension: #{name}"
  end
end

When(/^I try to parse the file with "(.*?)" class$/) do |parser|
  parser_klass = Pio.const_get(parser)
  if @raw
    parser_klass.read IO.read(@raw)
  elsif @pcap
    File.open(@pcap) do |file|
      pcap = Pio::Pcap::Frame.read(file)
      pcap.records.each { |each| parser_klass.read each.data }
    end
  else
    fail 'Packet data file is not specified.'
  end
end

Then(/^it should finish successfully$/) do
  # Noop.
end
