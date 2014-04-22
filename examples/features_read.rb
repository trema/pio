require 'pio'

features = Pio::Features.read(binary_data)
features.xid # => 123
