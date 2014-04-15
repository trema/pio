# Pio

<a href='https://rubygems.org/gems/pio'><img src='http://img.shields.io/gem/v/pio.svg' alt='Gem Version' /></a>
<a href='https://travis-ci.org/trema/pio'><img src='http://img.shields.io/travis/trema/pio/develop.svg' alt='Build Status' /></a>
<a href='https://codeclimate.com/github/trema/pio'><img src='http://img.shields.io/codeclimate/github/trema/pio.svg' alt='Code Climate' /></a>
<a href='https://coveralls.io/r/trema/pio?branch=develop'><img src='http://img.shields.io/coveralls/trema/pio/develop.svg' alt='Coverage Status' /></a>
<a href='https://gemnasium.com/trema/pio'><img src='https://gemnasium.com/trema/pio.svg' alt='Dependency Status' /></a>
<a href="http://inch-pages.github.io/github/trema/pio"><img src="http://inch-pages.github.io/github/trema/pio.svg" alt="Inline docs"></a>

<a href="http://www.flickr.com/photos/mongogushi/4226014070/" title="pio pencil by mongo gushi, on Flickr"><img src="http://farm5.staticflickr.com/4022/4226014070_cdeb7c1e5d_n.jpg" width="320" height="290" alt="pio pencil"></a>

Pio is a ruby gem to easily parse and generate network packets. It
supports the following packet formats:

-   ICMP
-   ARP
-   LLDP
-   DHCP
-   OpenFlow 1.0
    -   Hello
    -   Echo Request and Reply
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

To parse an ICMP frame, use the API `Pio::Icmp.read` and you can
access each field of the parsed ICMP frame.

    require 'pio'

    icmp = Pio::Icmp.read(binary_data)
    icmp.source_mac.to_s # => '00:26:82:eb:ea:d1'

Also you can use `Pio::Icmp::Request#new` or `Pio::Icmp::Reply#new` to
generate an Icmp Request/Reply frame like below:

    require 'pio'

    request = Pio::Icmp::Request.new(
      source_mac: '00:16:9d:1d:9c:c4',
      destination_mac: '00:26:82:eb:ea:d1',
      ip_source_address: '192.168.83.3',
      ip_destination_address: '192.168.83.254'
    )
    request.to_binary  # => ICMP Request frame in binary format.

    reply = Pio::Icmp::Reply.new(
      source_mac: '00:26:82:eb:ea:d1',
      destination_mac: '00:16:9d:1d:9c:c4',
      ip_source_address: '192.168.83.254',
      ip_destination_address: '192.168.83.3',
      # The ICMP Identifier and the ICMP Sequence number
      # should be same as those of the request.
      identifier: request.icmp_identifier,
      sequence_number: request.icmp_sequence_number
    )
    reply.to_binary  # => ICMP Reply frame in binary format.

### ARP

To parse an ARP frame, use the API `Pio::Arp.read` and you can access
each field of the parsed ARP frame.

    require 'pio'

    arp = Pio::Arp.read(binary_data)
    arp.source_mac.to_s # => '00:26:82:eb:ea:d1'

Also you can use `Pio::Arp::Request#new` or `Pio::Arp::Reply#new` to
generate an Arp Request/Reply frame like below:

    require 'pio'

    request = Pio::Arp::Request.new(
      source_mac: '00:26:82:eb:ea:d1',
      sender_protocol_address: '192.168.83.3',
      target_protocol_address: '192.168.83.254'
    )
    request.to_binary  # => Arp Request frame in binary format.

    reply = Pio::Arp::Reply.new(
      source_mac: '00:16:9d:1d:9c:c4',
      destination_mac: '00:26:82:eb:ea:d1',
      sender_protocol_address: '192.168.83.254',
      target_protocol_address: '192.168.83.3'
    )
    reply.to_binary  # => Arp Reply frame in binary format.

### LLDP

To parse an LLDP frame, use the API `Pio::Lldp.read` and you can
access each field of the parsed LLDP frame.

    require 'pio'

    lldp = Pio::Lldp.read(binary_data)
    lldp.ttl # => 120

Also you can use `Pio::Lldp#new` to generate an LLDP frame like below:

    require 'pio'

    lldp = Pio::Lldp.new(dpid: 0x123, port_number: 12)
    lldp.to_binary  # => LLDP frame in binary format.

### DHCP

To parse a DHCP frame, use the API `Pio::Dhcp.read` and you can access
each field of the parsed DHCP frame.

    require 'pio'

    dhcp = Pio::Dhcp.read(binary_data)
    dhcp.destination_mac.to_s  # => 'ff:ff:ff:ff:ff:ff'

Also you can use `Pio::Dhcp::Discover#new`,
`Pio::Dhcp::Offer#new`, `Pio::Dhcp::Request#new` and
`Pio::Dhcp::Ack#new` to generate a DHCP frame like below:

    require 'pio'

    discover = Pio::Dhcp::Discover.new(source_mac: '24:db:ac:41:e5:5b')
    discover.to_binary  # => DHCP Discover frame in binary format

    offer = Pio::Dhcp::Offer.new(
      source_mac: '00:26:82:eb:ea:d1',
      destination_mac: '24:db:ac:41:e5:5b',
      ip_source_address: '192.168.0.100',
      ip_destination_address: '192.168.0.1',
      transaction_id: discover.transaction_id
    )
    offer.to_binary  # => DHCP Offer frame in binary format

    request = Pio::Dhcp::Request.new(
      source_mac: '24:db:ac:41:e5:5b',
      server_identifier: '192.168.0.100',
      requested_ip_address: '192.168.0.1',
      transaction_id: offer.transaction_id
    )
    request.to_binary  # => DHCP Request frame in binary format

    ack = Pio::Dhcp::Ack.new(
      source_mac: '00:26:82:eb:ea:d1',
      destination_mac: '24:db:ac:41:e5:5b',
      ip_source_address: '192.168.0.100',
      ip_destination_address: '192.168.0.1',
      transaction_id: request.transaction_id
    )
    ack.to_binary  # => DHCP Ack frame in binary format

### Hello

To parse an OpenFlow 1.0 Hello message, use the API `Pio::Hello.read`
and you can access each field of the parsed Hello message.

    require 'pio'

    hello = Pio::Hello.read(binary_data)
    hello.transaction_id # => 123

Also you can use `Pio::Hello#new` to generate a Hello message like
below:

    require 'pio'

    hello = Pio::Hello.new(transaction_id: 123)
    hello.to_binary  # => HELLO message in binary format.

## ECHO

To parse an OpenFlow 1.0 ECHO message, use the API `Pio::Echo.read`
and you can access each field of the parsed ECHO message.

    require 'pio'

    echo = Pio::Echo.read(binary_data)
    echo.xid # => 123

Also you can use `Pio::Echo::Request#new` or `Pio::Echo::Reply#new` to
generate an Echo Request/Reply message like below:

    require 'pio'

    request = Pio::Echo::Request.new
    request.to_binary  # => ECHO Request message in binary format.

    # The ECHO xid (transaction_id)
    # should be same as those of the request.
    reply = Pio::Echo::Reply.new(xid: request.xid)
    reply.to_binary  # => ECHO Reply message in binary format.

## Installation

The simplest way to install Pio is to use [Bundler](http://gembundler.com/).

Add Pio to your `Gemfile`:

    gem 'pio'

and install it by running Bundler:

    prompt> bundle

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
