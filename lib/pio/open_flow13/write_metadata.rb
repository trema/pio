require 'forwardable'

# Base module.
module Pio
  # Write metadata
  class WriteMetadata
    # OpenFlow 1.3.4 OFPIT_WRITE_METADATA instruction format
    class Format < BinData::Record
      endian :big

      uint16 :instruction_type, value: 2
      uint16 :instruction_length, value: 24
      uint32 :padding
      uint64 :metadata
      uint64 :metadata_mask
    end

    def self.read(raw_data)
      allocate.tap do |write_metadata|
        write_metadata.instance_variable_set :@format, Format.read(raw_data)
      end
    end

    extend Forwardable

    def_delegators :@format, :instruction_type
    def_delegators :@format, :instruction_length
    def_delegators :@format, :metadata
    def_delegators :@format, :metadata_mask
    def_delegators :@format, :to_binary_s

    def initialize(user_options)
      @options = user_options
      @format = Format.new(options)
    end

    def options
      {
        metadata: metadata_option,
        metadata_mask: metadata_mask_option
      }
    end

    def metadata_option
      @options[:metadata]
    end

    def metadata_mask_option
      @options[:metadata_mask]
    end
  end
end
