require 'pio'

hello = Pio::Hello.read(binary_data)
hello.transaction_id # => 123
