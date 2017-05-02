# frozen_string_literal: true

require 'pio/open_flow13/write_metadata'

describe Pio::OpenFlow13::WriteMetadata do
  describe '.new' do
    When(:write_metadata) { Pio::OpenFlow13::WriteMetadata.new(options) }

    context 'with metadata: 1' do
      Given(:options) do
        {
          metadata: 0x1
        }
      end
      Then { write_metadata.metadata == 1 }
      Then { write_metadata.metadata_mask.zero? }
    end

    context 'with metadata: 1, metadata_mask: 1' do
      Given(:options) do
        {
          metadata: 0x1,
          metadata_mask: 0x1
        }
      end
      Then { write_metadata.metadata == 1 }
      Then { write_metadata.metadata_mask == 1 }
    end
  end
end
