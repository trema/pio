require 'pio/monkey_patch/uint'

describe BinData::Uint8 do
  describe '0#to_hex' do
    When(:result) { BinData::Uint8.new(0).to_hex }
    Then { result == '0x00' }
  end
end

describe BinData::Uint16be do
  describe '0#to_hex' do
    When(:result) { BinData::Uint16be.new(0).to_hex }
    Then { result == '0x00, 0x00' }
  end
end

describe BinData::Uint32be do
  describe '0#to_hex' do
    When(:result) { BinData::Uint32be.new(0).to_hex }
    Then { result == '0x00, 0x00, 0x00, 0x00' }
  end
end
