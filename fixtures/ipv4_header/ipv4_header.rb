[
  0b0100_0101, # ip_version, ip_header_length
  0x00, # ip_type_of_service
  0x00, 0x14, # ip_total_length
  0x00, 0x00, # ip_identifier
  0b000_0000000000000, # ip_flag, ip_fragment
  0x80, # ip_ttl
  0x00, # ip_protocol
  0x30, 0xe1, # ip_header_checksum
  0x01, 0x02, 0x03, 0x04, # source_ip_address
  0x04, 0x03, 0x02, 0x01, # destination_ip_address
].pack('C6nC12')
