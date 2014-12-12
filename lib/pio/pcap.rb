require 'bindata'

module Pio
  # .pcap file parser
  module Pcap
    BIG_ENDIAN = 0xa1b2c3d4
    LITTLE_ENDIAN = 0xd4c3b2a1

    LINKTYPE_ETHERNET = 1

    # Big or little endian?
    # This code smells of :reek:UncommunicativeModuleName
    class EndianMagicNumber16 < BinData::Choice
      int16be BIG_ENDIAN, initial_value: :value
      int16le LITTLE_ENDIAN, initial_value: :value
    end

    # Big or little endian?
    # This code smells of :reek:UncommunicativeModuleName
    class EndianMagicNumber32 < BinData::Choice
      int32be BIG_ENDIAN, initial_value: :value
      int32le LITTLE_ENDIAN, initial_value: :value
    end

    # .pcap format
    class Frame < BinData::Record
      byte_order = -> { file_header.magic }

      struct :file_header do
        hide :thiszone, :sigfigs

        uint32be :magic,
                 initial_value: 0xa1b2c3d4,
                 assert: -> { value == BIG_ENDIAN || value == LITTLE_ENDIAN }
        endian_magic_number16 :version_major, value: 2, selection: byte_order
        endian_magic_number16 :version_minor, value: 4, selection: byte_order
        endian_magic_number32 :thiszone, value: 0, selection: byte_order
        endian_magic_number32 :sigfigs, value: 0, selection: byte_order
        endian_magic_number32 :snaplen, value: 65_535, selection: byte_order
        endian_magic_number32 :linktype,
                              value: LINKTYPE_ETHERNET,
                              selection: byte_order
      end

      array :records, read_until: :eof do
        struct :pkthdr do
          struct :ts do
            endian_magic_number32 :sec, value: 0, selection: byte_order
            endian_magic_number32 :usec, value: 0, selection: byte_order
          end
          endian_magic_number32 :caplen,
                                value: -> { data.length },
                                selection: byte_order
          endian_magic_number32 :len,
                                value: -> { data.length },
                                selection: byte_order
        end
        string :data, read_length: -> { pkthdr.caplen }
      end
    end
  end
end
