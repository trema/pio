require 'pio'

hello = Pio::Hello.new(transaction_id: 123)
hello.to_binary  # => HELLO message in binary format.
