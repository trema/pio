# encoding: utf-8

require 'pio/pcap'

desc 'Dump .pcap file in Array'
task :dump_pcap do
  fail 'Usage: rake PCAP="foobar.pcap" dump_pcap' unless ENV['PCAP']
  pcap_file =
    File.join(File.dirname(__FILE__), '../features/pcap', ENV['PCAP'])
  File.open(pcap_file) do |file|
    Pio::Pcap::Frame.read(file).records.each do |each|
      hexdump = each.data.unpack('C*').map do |byte|
        format('0x%02x', byte)
      end
      puts "[#{hexdump.join(', ')}]"
    end
  end
end
