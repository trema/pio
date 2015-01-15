require 'pio'

flow_mod = Pio::FlowMod.new(transaction_id: 0x15,
                            buffer_id: 0xffffffff,
                            match: Pio::Match.new(in_port: 1),
                            cookie: 1,
                            command: :add,
                            priority: 0xffff,
                            out_port: 2,
                            flags: [:send_flow_rem, :check_overwrap],
                            actions: Pio::SendOutPort.new(2))

flow_mod.to_binary  # => Flow mod message in binary format.
