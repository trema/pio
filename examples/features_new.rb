require 'pio'

request = Pio::Features::Request.new
request.to_binary  # => Features Request message in binary format.

# The Features xid (transaction_id)
# should be same as that of the request.
reply = Pio::Features::Reply.new(
  xid: request.xid,
  dpid: 0x123,
  n_buffers: 0x100,
  n_tables: 0xfe,
  capabilities: [:flow_stats, :table_stats, :port_stats,
                 :queue_stats, :arp_match_ip],
  actions: [:output, :set_vlan_vid, :set_vlan_pcp, :strip_vlan,
            :set_dl_src, :set_dl_dst, :set_nw_src, :set_nw_dst,
            :set_nw_tos, :set_tp_src, :set_tp_dst, :enqueue],
  ports: [{ port_no: 1,
            hardware_address: '11:22:33:44:55:66',
            name: 'port123',
            config: [:port_down],
            state: [:link_down],
            curr: [:port_10gb_fd, :port_copper] }]
        )
reply.to_binary  # => Features Reply message in binary format.
