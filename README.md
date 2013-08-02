Pio
===
[![Gem Version](https://badge.fury.io/rb/pio.png)](http://badge.fury.io/rb/pio)
[![Build Status](https://travis-ci.org/trema/pio.png?branch=develop)](https://travis-ci.org/trema/pio)
[![Code Climate](https://codeclimate.com/github/trema/pio.png)](https://codeclimate.com/github/trema/pio)
[![Coverage Status](https://coveralls.io/repos/trema/pio/badge.png?branch=develop)](https://coveralls.io/r/trema/pio)
[![Dependency Status](https://gemnasium.com/trema/pio.png)](https://gemnasium.com/trema/pio)

Packet parser and generator


Example
-------

Its usage is dead simple: to parse an LLDP frame for example, use the
API `Pio::Lldp.read` and you can access each field of the parsed LLDP
frame.

```ruby
require "pio"

lldp = Pio::Lldp.read( binary_data )
lldp.ttl #=> 120
```

Also you can use `Pio::Lldp#new` to generate an LLDP frame like below:

```ruby
require "pio"

lldp = Pio::Lldp.new( 0x123, 12 )  # dpid and port_number
lldp.to_binary  #=> LLDP frame in binary literal.
```


Installation
------------

The simplest way to install Pio is to use [Bundler](http://gembundler.com/).

Add Pio to your `Gemfile`:

```ruby
gem 'pio'
```

and install it by running Bundler:

```bash
$ bundle
```


Documents
---------

 * [API document generated with YARD](http://rubydoc.info/github/trema/pio/frames/file/README.md)


### Author

[Yasuhito Takamiya](https://github.com/yasuhito) ([@yasuhito](http://twitter.com/yasuhito))

### Contributors

[https://github.com/trema/pio/contributors](https://github.com/trema/pio/contributors)


Alternatives
------------

 * PacketFu: https://github.com/todb/packetfu
 * Racket: http://spoofed.org/files/racket/


License
-------

Trema is released under the GNU General Public License version 3.0:

* http://www.gnu.org/licenses/gpl.html
