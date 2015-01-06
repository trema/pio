# Changelog

## 0.10.0 (1/6/2015)

### New features
* [#103](https://github.com/trema/pio/pull/103): Added new class `Pio::PacketOut`.


## 0.9.0 (12/22/2014)

### New features
* [#102](https://github.com/trema/pio/pull/102): Added new class `Pio::PacketIn`.


## 0.8.2 (12/18/2014)

### Bugs fixed
* [#100](https://github.com/trema/pio/pull/100): Fix bug when passing `ports:` option to `Pio::Features::Request.new`.


## 0.8.1 (6/5/2014)

### Misc
* Updated bundled gems.
* Modernized Gemfile and .gemspec.


## 0.8.0 (5/26/2014)

### Changes
* Renamed `version` => `ofp_version`


## 0.7.0 (4/22/2014)

### New features
* Added new class `Pio::Features`, `Pio::Features::Request` and `Pio::Features::Reply`

### Changes
* Renamed `rake PCAP='foo.pcap' dump_pcap` => `rake PACKET_FILE='foo.pcap' dump`


## 0.6.0 (4/15/2014)

### New features
* Added new class `Pio::Echo`, `Pio::Echo::Request` and `Pio::Echo::Reply`.


## 0.5.1 (4/15/2014)

### Bugs fixed
* Set hello message type = 0.


## 0.5.0 (4/14/2014)

### New features
* Added new class `Pio::Hello`.

### Misc
* Added new rake task `cucumber`.
* Added new rake task `dump_pcap`.


## 0.4.0 (3/31/2014)

### New features
* Added new classes `Pio::Dhcp`, `Pio::Dhcp::Discover`,
  `Pio::Dhcp::Offer`, `Pio::Dhcp::Request` and `Pio::Dhcp::Ack`.

### Changes
* Added new class alias `Pio::ICMP` => `Pio::Icmp`.
* Added new class alias `Pio::ARP` => `Pio::Arp`.
* Added new class alias `Pio::LLDP` => `Pio::Lldp`.
* Added new class alias `Pio::DHCP` => `Pio::Dhcp`.
