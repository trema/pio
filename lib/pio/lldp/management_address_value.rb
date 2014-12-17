require 'bindata'

module Pio
  class Lldp
    # TLV value field of management address TLV
    class ManagementAddressValue < BinData::Record
      endian :big

      uint8 :string_length
      uint8 :subtype
      string :management_address, read_length: -> { string_length - 1 }
      uint8 :interface_numbering_subtype
      uint32 :interface_number
      uint8 :oid_string_length
      string :object_identifier, read_length: -> { oid_string_length }
    end
  end
end
