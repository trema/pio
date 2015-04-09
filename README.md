# Pio

<a href='https://rubygems.org/gems/pio'><img src='http://img.shields.io/gem/v/pio.svg?style=flat' alt='Gem Version' /></a>
<a href='https://travis-ci.org/trema/pio'><img src='http://img.shields.io/travis/trema/pio/develop.svg?style=flat' alt='Build Status' /></a>
<a href='https://codeclimate.com/github/trema/pio'><img src='http://img.shields.io/codeclimate/github/trema/pio.svg?style=flat' alt='Code Climate' /></a>
<a href='https://coveralls.io/r/trema/pio?branch=develop'><img src='http://img.shields.io/coveralls/trema/pio/develop.svg?style=flat' alt='Coverage Status' /></a>
<a href='https://gemnasium.com/trema/pio'><img src='http://img.shields.io/gemnasium/trema/pio.svg?style=flat' alt='Dependency Status' /></a>
<a href='https://gitter.im/trema/pio'><img src='https://badges.gitter.im/Join Chat.svg?style=flat' alt='Gitter Chat' /></a>
<a href="http://inch-pages.github.io/github/trema/pio"><img src="http://inch-pages.github.io/github/trema/pio.svg" alt="Inline docs"></a>

<a href="http://www.flickr.com/photos/mongogushi/4226014070/" title="pio pencil by mongo gushi, on Flickr"><img src="http://farm5.staticflickr.com/4022/4226014070_cdeb7c1e5d_n.jpg" width="320" height="290" alt="pio pencil"></a>

Pio is a ruby gem to easily parse and generate network packets. It
supports the following packet formats:

- [ICMP](https://relishapp.com/trema/pio/docs/misc/icmp)
- [ARP](https://relishapp.com/trema/pio/docs/misc/arp)
- [LLDP](https://relishapp.com/trema/pio/docs/misc/lldp)
- [DHCP](https://relishapp.com/trema/pio/docs/misc/dhcp)
- [UDP](https://relishapp.com/trema/pio/docs/misc/udp)
- OpenFlow 1.0
  - [Hello](https://relishapp.com/trema/pio/docs/open-flow10/hello)
  - [Echo Request](https://relishapp.com/trema/pio/docs/open-flow10/echo-request)
  - [Echo Reply](https://relishapp.com/trema/pio/docs/open-flow10/echo-reply)
  - [Features Request](https://relishapp.com/trema/pio/docs/open-flow10/features-request)
  - [Features Reply](https://relishapp.com/trema/pio/docs/open-flow10/features-reply)
  - [Packet In](https://relishapp.com/trema/pio/docs/open-flow10/packet-in)
  - [Packet Out](https://relishapp.com/trema/pio/docs/open-flow10/packet-out)
  - [Flow Mod](https://relishapp.com/trema/pio/docs/open-flow10/flow-mod)
  - [Port Status](https://relishapp.com/trema/pio/docs/open-flow10/port-status)
- OpenFlow 1.3
  - [Hello](https://relishapp.com/trema/pio/docs/open-flow13/hello)
  - [Echo Request](https://relishapp.com/trema/pio/docs/open-flow13/echo-request)
  - [Echo Reply](https://relishapp.com/trema/pio/docs/open-flow13/echo-reply)

## Features Overview

- Pure Ruby. No additional dependency on other external tools to
  parse/generate packets.
- Multi-Platform. Runs on major operating systems (recent Windows,
  Linux, and MacOSX).
- Clean Code. Pio is built on
  [BinData](https://github.com/dmendel/bindata)'s declarative binary
  format DSL so that it is easy to read and debug by human beings.

## Installation

The simplest way to install Pio is to use [Bundler](http://gembundler.com/).

Add Pio to your `Gemfile`:

```ruby
gem 'pio'
```

and install it by running Bundler:

```bash
bundle
```

## Documents

- [API document generated with YARD](http://rubydoc.info/github/trema/pio/frames/file/README.md)

## Team

- [Yasuhito Takamiya](https://github.com/yasuhito) ([@yasuhito](https://twitter.com/yasuhito))
- [Eishun Kondoh](https://github.com/shun159) ([@Eishun\_Kondoh](https://twitter.com/Eishun_Kondoh))

### Contributors

<https://github.com/trema/pio/contributors>

## Alternatives

- PacketFu: <https://github.com/todb/packetfu>
- Racket: <http://spoofed.org/files/racket/>

## License

Pio is released under the GNU General Public License version 3.0:

- <http://www.gnu.org/licenses/gpl.html>
