# Changelog

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
