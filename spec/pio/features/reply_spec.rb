# encoding: utf-8

require 'pio/features'

describe Pio::Features::Reply do
  describe '.new' do
    Given(:options) do
      {
        dpid: 0x123,
        n_buffers: 0x100,
        n_tables: 0xfe,
        capabilities: 0xc7,
        actions: 0xfff
      }
    end

    When(:features_reply) { Pio::Features::Reply.new(options) }

    Then { features_reply.ofp_version == 1 }
    Then { features_reply.message_type == Pio::OpenFlow::Type::FEATURES_REPLY }
    Then { features_reply.transaction_id == 0 }
    Then { features_reply.xid == 0 }
    Then { features_reply.dpid == 0x123 }
    Then { features_reply.n_buffers == 0x100 }
    Then { features_reply.n_tables == 0xfe }
    Then { features_reply.capabilities == 0xc7 }
    Then { features_reply.actions == 0xfff }
    Then { features_reply.ports == [] }
  end
end
