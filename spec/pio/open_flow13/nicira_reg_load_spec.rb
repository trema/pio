require 'pio/open_flow13/nicira_reg_load'

describe Pio::OpenFlow13::NiciraRegLoad do
  describe '.new' do
    When(:nicira_reg_load) do
      Pio::OpenFlow13::NiciraRegLoad.new(value, destination, options)
    end

    context 'with 0xdeadbeef, :reg0' do
      Given(:value) { 0xdeadbeef }
      Given(:destination) { :reg0 }
      Given(:options) { {} }

      Invariant do
        nicira_reg_load.n_bits == nicira_reg_load._destination[:oxm_length] * 8
      end

      Then { nicira_reg_load.action_type == 0xffff }
      Then { nicira_reg_load.action_length == 24 }
      Then { nicira_reg_load.vendor == 0x2320 }
      Then { nicira_reg_load.subtype == 7 }
      Then { nicira_reg_load.offset == 0 }
      Then { nicira_reg_load.n_bits == 32 }
      Then { nicira_reg_load.destination == :reg0 }
      Then { nicira_reg_load._destination[:oxm_class] == 1 }
      Then { nicira_reg_load._destination[:oxm_field] == 0 }
      Then { nicira_reg_load._destination[:oxm_length] == 4 }
      Then { nicira_reg_load.value == 0xdeadbeef }
    end

    context 'with 0xdeadbeef, :metadata' do
      Given(:value) { 0xdeadbeef }
      Given(:destination) { :metadata }
      Given(:options) { {} }

      Invariant do
        nicira_reg_load.n_bits == nicira_reg_load._destination[:oxm_length] * 8
      end

      Then { nicira_reg_load.action_type == 0xffff }
      Then { nicira_reg_load.action_length == 24 }
      Then { nicira_reg_load.vendor == 0x2320 }
      Then { nicira_reg_load.subtype == 7 }
      Then { nicira_reg_load.offset == 0 }
      Then { nicira_reg_load.n_bits == 64 }
      Then { nicira_reg_load.destination == :metadata }
      Then { nicira_reg_load._destination[:oxm_class] == 0x8000 }
      Then { nicira_reg_load._destination[:oxm_field] == 2 }
      Then { nicira_reg_load._destination[:oxm_length] == 8 }
      Then { nicira_reg_load.value == 0xdeadbeef }
    end

    context 'with 0xdeadbeef, :reg0, offset: 16, n_bits: 16' do
      Given(:value) { 0xdeadbeef }
      Given(:destination) { :reg0 }
      Given(:options) { { offset: 16, n_bits: 16 } }

      Then { nicira_reg_load.action_type == 0xffff }
      Then { nicira_reg_load.action_length == 24 }
      Then { nicira_reg_load.vendor == 0x2320 }
      Then { nicira_reg_load.subtype == 7 }
      Then { nicira_reg_load.offset == 16 }
      Then { nicira_reg_load.n_bits == 16 }
      Then { nicira_reg_load.destination == :reg0 }
      Then { nicira_reg_load._destination[:oxm_class] == 1 }
      Then { nicira_reg_load._destination[:oxm_field] == 0 }
      Then { nicira_reg_load._destination[:oxm_length] == 4 }
      Then { nicira_reg_load.value == 0xdeadbeef }
    end
  end
end
