require 'pio'

request = Pio::Echo::Request.new
request.to_binary  # => ECHO Request message in binary format.

# The ECHO xid (transaction_id)
# should be same as those of the request.
reply = Pio::Echo::Reply.new(xid: request.xid)
reply.to_binary  # => ECHO Reply message in binary format.
