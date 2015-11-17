# Changelog

## develop (unreleased)

## 0.30.0 (11/17/2015)
### New features
* [#281](https://github.com/trema/pio/pull/281): Add `NiciraRegLoad` action.
* [#282](https://github.com/trema/pio/pull/282): Add `NiciraResubmit` action.
* [#283](https://github.com/trema/pio/pull/283): Add `SetMetadata` action.
* [#284](https://github.com/trema/pio/pull/284): Enable masking with reg0-reg7.
* [#285](https://github.com/trema/pio/pull/285): Add Nicira `SendOutPort` action.


## 0.29.0 (11/11/2015)
### New features
* [#274](https://github.com/trema/pio/pull/274): Add `SetSourceMacAddress` action.
* [#275](https://github.com/trema/pio/pull/275): Add `SetDestinationMacAddress` action.
* [#276](https://github.com/trema/pio/pull/276): Add `SetArpOperation` action.
* [#277](https://github.com/trema/pio/pull/277): Add `SetArpSenderProtocolAddress` action.
* [#278](https://github.com/trema/pio/pull/278): Add `SetArpSenderHardwareAddress` action.
* [#280](https://github.com/trema/pio/pull/280): Add `NiciraRegMove` action.


## 0.28.1 (11/5/2015)
### Changes
* Remove `OpenFlow10` namespace from `Pio::OpenFlow10::SetSourceMacAddress` and `Pio::OpenFlow10::SetDestinationMacAddress`.


## 0.28.0 (11/5/2015)
### New features
* [#267](https://github.com/trema/pio/pull/267): Add Queue Stats Request message generator.
* [#266](https://github.com/trema/pio/pull/266): Add Port Stats Request message generator.
* [#252](https://github.com/trema/pio/pull/252): Add NiciraResubmit and NiciraResubmitTable actions.
* [#251](https://github.com/trema/pio/pull/251): Add Table Stats Request message generator.
* [#250](https://github.com/trema/pio/pull/250): Add Flow Removed message parser.

### Changes
* [#272](https://github.com/trema/pio/pull/272): Rename `Match` option: `:ip_source_address` -> `:source_ip_address` and `:ip_destination_address` -> `:destination_ip_address`.
* [#271](https://github.com/trema/pio/pull/271): Rename `Match` option: `:ether_destination_address` -> `:destination_mac_address`.
* [#270](https://github.com/trema/pio/pull/270): Rename `Match` option: `:ether_source_address` -> `:source_mac_address`.
* [#269](https://github.com/trema/pio/pull/269): Rename `SetIpSourceAddress` -> `SetSourceIpAddress` and `SetIpDestinationAddress` -> `SetDestinationIpAddress`.
* [#268](https://github.com/trema/pio/pull/268): Rename `SetEtherSourceAddress` -> `SetSourceMacAddress` and `SetEtherDestinationAddress` -> `SetDestinationMacAddress`.
* [#265](https://github.com/trema/pio/pull/265): Rename `SetIpTos` -> `SetTos`.


## 0.27.2 (10/25/2015)
### New features
* [#244](https://github.com/trema/pio/pull/244): Support ARP in `ExactMatch.new`.

### Changes
* [#242](https://github.com/trema/pio/issues/242): Fix `Parser#read` to avoid fail in parsing unsupported eth\_type frame.


## 0.27.1 (9/28/2015)
### Bugs fixed
* [#238](https://github.com/trema/pio/issues/238): `Features::Reply#datapath_id` doesn't return an Integer.


## 0.27.0 (9/16/2015)
### New features
* [#203](https://github.com/trema/pio/pull/203): Add new classes `Pio::OpenFlow10::DescriptionStats::Request`, `Pio::OpenFlow10::DescriptionStats::Reply`, `Pio::OpenFlow10::FlowStats::Request`, `Pio::OpenFlow10::FlowStats::Reply`, `Pio::OpenFlow10::AggregateStats::Request`, `Pio::OpenFlow10::AggregateStats::Reply`.


## 0.26.0 (9/8/2015)
### New features
* [#214](https://github.com/trema/pio/pull/214): Add new class `Pio::OpenFlow10::Error::HelloFailed`.
* [#215](https://github.com/trema/pio/pull/215): Add new class `Pio::OpenFlow13::Error::HelloFailed`.
* [#216](https://github.com/trema/pio/pull/216): Add new class `Pio::OpenFlow10::Error::BadRequest`.
* [#217](https://github.com/trema/pio/pull/217): Add new class `Pio::OpenFlow13::Error::BadRequest`.


## 0.25.0 (8/6/2015)
### New features
* [#211](https://github.com/trema/pio/pull/211): Add new classes `Pio::FlowStats::Request` and `Pio::FlowStats::Reply`.


## 0.24.2 (8/4/2015)
### Bugs fixed
* [#209](https://github.com/trema/pio/issues/209): `Pio::OpenFlow.read` cannot parse Barrier messages.


## 0.24.1 (8/4/2015)
### Bugs fixed
* [#208](https://github.com/trema/pio/issues/208): `Pio::FlowMod.new` doesn't allow `:idle_timeout` and `:hard_timeout` options.


## 0.24.0 (8/1/2015)
### New features
* [#201](https://github.com/trema/pio/pull/201): Add oxm experimenter support (OpenFlow1.3).
* [#202](https://github.com/trema/pio/pull/202): Add `Pio::OpenFlow.switch_version` method.
* [#205](https://github.com/trema/pio/pull/205): Add new classes `Pio::OpenFlow10::Barrier::Request`, `Pio::OpenFlow10::Barrier::Reply`.
* [#207](https://github.com/trema/pio/pull/207): Add new method `Pio::OpenFlow.read`

### Bugs fixed
* [#188](https://github.com/trema/pio/pull/188): Add PacketIn#in_port (OpenFlow1.3).
* [#189](https://github.com/trema/pio/pull/189): Add PacketIn#datapath_id= (OpenFlow1.3).
* [#190](https://github.com/trema/pio/pull/190): Add PacketOut#to_binary (OpenFlow1.3).
* [#191](https://github.com/trema/pio/pull/191): Add GotoTable#to_binary_s.
* [#192](https://github.com/trema/pio/pull/192): Add Meter#to_binary_s.
* [#193](https://github.com/trema/pio/pull/193): Add WriteMetadata#to_binary_s.


## 0.23.1 (6/30/2015)
### Bugs fixed
* [#186](https://github.com/trema/pio/issues/186): Add the missing `FlowMod#to_binary` method.


## 0.23.0 (6/29/2015)
### New features
* [#183](https://github.com/trema/pio/pull/183): Add new class `Pio::PacketIn` (OpenFlow1.3).
* [#185](https://github.com/trema/pio/pull/185): Add new classes `Pio::Match::TunnelId` and `Pio::Match::MaskedTunnelId`
* [#184](https://github.com/trema/pio/pull/184): Add new classes `Pio::Match::ArpOp`, `Pio::Match::ArpSenderProtocolAddress`, `Pio::Match::ArpTargetProtocolAddress`, `Pio::Match::ArpSenderHardwareAddress`, `Pio::Match::ArpTargetHardwareAddress`, `Pio::Match::MaskedArpSenderProtocolAddress`,`Pio::Match::MaskedArpTargetProtocolAddress`, `Pio::Match::MaskedArpSenderHardwareAddress` and `Pio::Match::MaskedArpTargetHardwareAddress`


## 0.22.0 (6/25/2015)
### New features
* [#177](https://github.com/trema/pio/pull/177): Add new class `Pio::PacketIn` (OpenFlow1.3).
* [#173](https://github.com/trema/pio/pull/173): Add new classes `Pio::Match::VlanVid`, `Pio::Match::VlanPcp`.
* [#174](https://github.com/trema/pio/pull/174): Add new classes `Pio::Match::IpDscp`, `Pio::Match::IpEcn`.
* [#178](https://github.com/trema/pio/pull/178): Add new classes `Pio::Match::SctpSourcePort`, `Pio::Match::SctpDestinationPort`.
* [#180](https://github.com/trema/pio/pull/180): Add new classes `Pio::Match::Icmpv4Type`, `Pio::Match::Icmpv4Code`.


## 0.21.1 (6/24/2015)
### Bugs fixed
* [#179](https://github.com/trema/pio/pull/179): Fix wrong OXM length.


## 0.21.0 (6/19/2015)
### New features
* [#164](https://github.com/trema/pio/pull/164): Add new classes `Pio::FlowMod`, `Pio::Apply`, `Pio::GotoTable`, `Pio::WriteMetadata`, `Pio::Meter` and `Pio::SendOutPort`.


## 0.20.1 (6/10/2015)
### Bugs fixed
* [#167](https://github.com/trema/pio/pull/167): Fix PacketIn accessor methods (raw_data = VLAN tagged UDP).


## 0.20.0 (4/22/2015)
### New features
* [#138](https://github.com/trema/pio/pull/138): Add new class `Pio::Features::Request`.
* [#153](https://github.com/trema/pio/pull/153): Add new class `Pio::Features::Reply`.


## 0.19.0 (4/9/2015)
### New features
* [#132](https://github.com/trema/pio/pull/132): Add new class `Pio::Hello13`.
* [#136](https://github.com/trema/pio/pull/136): Add new class `Pio::Echo13::Request` and `Pio::Echo13::Reply`.


## 0.18.2 (3/12/2015)
### New features
* Add attr writers to `Pio::Match` and `Pio::ExactMatch`.


## 0.18.1 (3/11/2015)
### Changes
* `Lldp#port_number` returns primitive Ruby objects.


## 0.18.0 (3/9/2015)
### Changes
* Deprecated `Pio::Mac#== Integer`.
* `Pio::PacketIn#source_mac` and `Pio::PacketIn#destination_mac` returns `Pio::Mac`.


## 0.17.0 (3/6/2015)
### Changes
* Renamed `Pio::PacketIn#data` => `Pio::PacketIn#raw_data`.
* Renamed `Pio::PacketOut#data` => `Pio::PacketOut#raw_data`.
* Fix behavior of `IPv4Address#eql?` and `IPv4Address#hash`.


## 0.16.0 (3/2/2015)
### New features
* [#129](https://github.com/trema/pio/pull/129): Add new class `Pio::Udp`.


## 0.15.2 (2/18/2015)
### Changes
* [#128](https://github.com/trema/pio/pull/128): Field accessors return Ruby primitives (Fixnum, Symbol, etc.).


## 0.15.1 (2/17/2015)
### Bugs fixed
* [#127](https://github.com/trema/pio/pull/127): Make OpenFlow classes thread safe.


## 0.15.0 (2/12/2015)
### New features
* [#126](https://github.com/trema/pio/pull/126): Add new class `Pio::PortStatus`.
* [#126](https://github.com/trema/pio/pull/126): Add new methods `Pio::Type::OpenFlow::PhyPort#up?`, `Pio::Type::OpenFlow::PhyPort#down?`, `Pio::Type::OpenFlow::PhyPort#local?`, `Pio::Type::OpenFlow::PhyPort#datapath_id` and `Pio::Type::OpenFlow::PhyPort#dpid`.
* [#126](https://github.com/trema/pio/pull/126): Add new methods `Pio::PacketIn#lldp?`.
* [#126](https://github.com/trema/pio/pull/126): Add new methods `Pio::Features::Reply#physical_ports`.


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
