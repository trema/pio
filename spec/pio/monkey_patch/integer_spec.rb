require 'pio/monkey_patch/integer'

describe MonkeyPatch::Integer::BaseConversions do
  describe '0#to_hex' do
    When(:result) { 0.to_hex }
    Then { result == '0x00' }
  end

  describe '1#to_hex' do
    When(:result) { 1.to_hex }
    Then { result == '0x01' }
  end

  describe '250#to_hex' do
    When(:result) { 250.to_hex }
    Then { result == '0xfa' }
  end

  describe '4207849484#to_hex' do
    When(:result) { 4_207_849_484.to_hex }
    Then { result == '0xfaceb00c' }
  end
end
