require 'pio'

request = Pio::Features::Request.new
request.to_binary  # => Features Request message in binary format.

# The Features xid (transaction_id)
# should be same as that of the request.
reply = Pio::Features::Reply.new(xid: request.xid,
                                 dpid: 0x123,
                                 n_buffers: 0x100,
                                 n_tables: 0xfe,
                                 capabilities: 0xc7,
                                 actions: 0xfff)
reply.to_binary  # => Features Reply message in binary format.
