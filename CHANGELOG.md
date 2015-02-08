# Changelog

## develop (unreleased)


## 0.14.0 (2/9/2015)
### New features
* [#125](https://github.com/trema/pio/pull/125): Add new accessor methods `Pio::PacketIn#datapath_id` and `Pio::PacketIn#dpid`.


## 0.13.0 (2/6/2015)
### New features
* [#124](https://github.com/trema/pio/pull/124): Add new methods `Pio::PacketIn#source_mac` and `Pio::PacketIn#destination_mac`.


## 0.12.0 (2/5/2015)
### New features
* [#123](https://github.com/trema/pio/pull/123): Add new class `Pio::ExactMatch`.


## 0.11.2 (1/29/2015)
### Bugs fixed
* [#121](https://github.com/trema/pio/pull/121): Fix behavior of `Pio::Match#==` and `Pio::SendOutPort#==`.


## 0.11.1 (1/15/2015)
### New features
* [#116](https://github.com/trema/pio/issues/116): Support Cisco-style MAC addresses.


## 0.11.0 (1/15/2015)
### New features
* [#108](https://github.com/trema/pio/pull/108): Added new class `Pio::FlowMod` and `Pio::Match`.


## 0.10.1 (1/6/2015)
### Bugs fixed
* [#104](https://github.com/trema/pio/issues/104): Fix bug when parsing `Pio::PacketOut` with `Pio::StripVlanHeader` action.


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
