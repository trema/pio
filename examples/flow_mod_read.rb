require 'pio'

flow_mod = Pio::FlowMod.read(binary_data)
flow_mod.match.in_port # => 1
flow_mod.match.dl_src # => '00:00:00:00:00:0a'
# ...
