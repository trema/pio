shared_examples 'an OpenFlow message' do |klass|
  describe '.new' do
    When(:message) { klass.new(options) }

    context 'with transaction_id: 123' do
      Given(:options) { { transaction_id: 123 } }

      Then { message.transaction_id == 123 }
      Then { message.xid == 123 }
    end

    context 'with transaction_id: -1' do
      When(:options) { { transaction_id: -1 } }

      Then { message == Failure(ArgumentError, 'Transaction ID should be an unsigned 32-bit integer.') }
    end

    context 'with transaction_id: 2**32' do
      When(:options) { { transaction_id: 2**32 } }

      Then { message == Failure(ArgumentError, 'Transaction ID should be an unsigned 32-bit integer.') }
    end

    context 'with UNKNOWN_OPTION: :UNKNOWN_VALUE' do
      When(:options) { { UNKNOWN_OPTION: :UNKNOWN_VALUE } }

      Then { message == Failure(RuntimeError, 'Unknown option: UNKNOWN_OPTION') }
    end
  end

  describe '.read' do
    When(:result) { klass.read(binary) }

    context "with 'DEADBEEF'" do
      Given(:binary) { 'DEADBEEF' }
      Then { result == Failure(Pio::ParseError) }
    end
  end
end

shared_examples 'an OpenFlow message with no body' do |klass|
  describe '.new' do
    When(:message) { klass.new(options) }

    context "with body: 'DEADBEEF'" do
      When(:options) { { body: 'DEADBEEF' } }

      Then { message.body == '' }
    end
  end
end

shared_examples 'an OpenFlow message with Datapath ID' do |klass|
  When(:message) { klass.new(options) }

  context 'with { datapath_id: -1 }' do
    Given(:options) { { datapath_id: -1 } }
    Then do
      message == Failure(ArgumentError,
                         'Datapath ID should be an unsigned 64-bit integer.')
    end
  end

  context 'with { datapath_id: 0 }' do
    Given(:options) { { datapath_id: 0 } }
    Then { message.datapath_id == 0 }
    And { message.datapath_id.is_a? Integer }
  end

  context 'with { datapath_id: 2**64 - 1 }' do
    Given(:options) { { datapath_id: 2**64 - 1 } }
    Then { message.datapath_id == 2**64 - 1 }
    And { message.datapath_id.is_a? Integer }
  end

  context 'with { datapath_id: 2**64 }' do
    Given(:options) { { datapath_id: 2**64 } }
    Then do
      message == Failure(ArgumentError,
                         'Datapath ID should be an unsigned 64-bit integer.')
    end
  end
end
