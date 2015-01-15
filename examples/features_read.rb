require 'pio'

features = Pio::Features::Request.read(binary_data)
features.xid # => 123
