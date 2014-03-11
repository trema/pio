# Pio

[![Gem Version](https://badge.fury.io/rb/pio.png)](http://badge.fury.io/rb/pio)
[![Build Status](https://travis-ci.org/trema/pio.png?branch=develop)](https://travis-ci.org/trema/pio)
[![Code Climate](https://codeclimate.com/github/trema/pio.png)](https://codeclimate.com/github/trema/pio)
[![Coverage Status](https://coveralls.io/repos/trema/pio/badge.png?branch=develop)](https://coveralls.io/r/trema/pio)
[![Dependency Status](https://gemnasium.com/trema/pio.png)](https://gemnasium.com/trema/pio)

<a href="http://www.flickr.com/photos/mongogushi/4226014070/" title="pio pencil by mongo gushi, on Flickr"><img src="http://farm5.staticflickr.com/4022/4226014070_cdeb7c1e5d_n.jpg" width="320" height="290" alt="pio pencil"></a>

Pio is a ruby gem to easily parse and generate network packets. It
supports the following packet formats:

-   ICMP
-   ARP
-   LLDP
-   (&#x2026;currently there are just a few formats supported but I'm sure this list will grow)

## Features Overview

-   Pure Ruby. No additional dependency on other external tools to
    parse/generate packets.
-   Multi-Platform. Runs on major operating systems (recent Windows,
    Linux, and MacOSX).
-   Clean Code. Pio is built on [BinData](https://github.com/dmendel/bindata)'s declarative binary format DSL
    so that it is easy to read and debug by human beings.

## Examples

Its usage is dead simple.

### ICMP

To parse an ICMP frame, use the API \`Pio::Icmp.read\` and you can
access each field of the parsed ICMP frame.

    require 'pio'

    icmp = Pio::Icmp.read(binary_data)
    icmp.source_mac.to_s #=> '00:26:82:eb:ea:d1'

Also you can use \`Pio::Icmp::Request#new\` or \`Pio::Icmp::Reply#new\` to
generate an Icmp Request/Reply frame like below:

    require 'pio'

    request = Pio::Icmp::Request.new(
      source_mac: '00:26:82:eb:ea:d1',
      destination_mac: '00:26:82:eb:ea:d1',
      ip_source_address: '192.168.83.3',
      ip_destination_address: '192.168.83.254'
    )
    request.to_binary  #=> ICMP Request frame in binary format.

    reply = Pio::Icmp::Reply.new(
      destination_mac: '00:26:82:eb:ea:d1',
      source_mac: '00:00:00:00:00:01',
      ip_source_address: '192.168.0.1',
      ip_destination_address: '192.168.0.2',
      # The ICMP Identifier and the ICMP Sequence number
      # should be same as those of the request.
      icmp_identifier: request.icmp_identifier,
      icmp_sequence_number: request.icmp_sequence_number,
      echo_data: request.echo_data
    )
    reply.to_binary  #=> ICMP Reply frame in binary format.

### ARP

To parse an ARP frame, use the API `Pio::Arp.read` and you can access
each field of the parsed ARP frame.

    require 'pio'

    arp = Pio::Arp.read(binary_data)
    arp.source_mac.to_s #=> '00:26:82:eb:ea:d1'

Also you can use `Pio::Arp::Request#new` or `Pio::Arp::Reply#new` to
generate an Arp Request/Reply frame like below:

    require 'pio'

    request = Pio::Arp::Request.new(
      source_mac: '00:26:82:eb:ea:d1',
      sender_protocol_address: '192.168.83.3',
      target_protocol_address: '192.168.83.254'
    )
    request.to_binary  #=> Arp Request frame in binary format.

    reply = Pio::Arp::Reply.new(
      source_mac: '00:26:82:eb:ea:d1',
      destination_mac: '00:26:82:eb:ea:d1',
      sender_protocol_address: '192.168.83.3',
      target_protocol_address: '192.168.83.254'
    )
    reply.to_binary  #=> Arp Reply frame in binary format.

### LLDP

To parse an LLDP frame, use the API `Pio::Lldp.read` and you can
access each field of the parsed LLDP frame.

    require 'pio'

    lldp = Pio::Lldp.read(binary_data)
    lldp.ttl #=> 120

Also you can use `Pio::Lldp#new` to generate an LLDP frame like below:

    require 'pio'

    lldp = Pio::Lldp.new(dpid: 0x123, port_number: 12)
    lldp.to_binary  #=> LLDP frame in binary format.

## Installation

The simplest way to install Pio is to use [Bundler](http://gembundler.com/).

Add Pio to your `Gemfile`:

    gem 'pio'

and install it by running Bundler:

    $ bundle

## Documents

-   [API document generated with YARD](http://rubydoc.info/github/trema/pio/frames/file/README.md)

## Team

-   [Yasuhito Takamiya](https://github.com/yasuhito) ([@yasuhito](https://twitter.com/yasuhito))
-   [Eishun Kondoh](https://github.com/shun159) ([@Eishun\_Kondoh](https://twitter.com/Eishun_Kondoh))

### Contributors

<https://github.com/trema/pio/contributors>

## Alternatives

-   PacketFu: <https://github.com/todb/packetfu>
-   Racket: <http://spoofed.org/files/racket/>

## License

Pio is released under the GNU General Public License version 3.0:
-   <http://www.gnu.org/licenses/gpl.html>
