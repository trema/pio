module Pio
  # defines to_ruby method
  module RubyDumper
    # Returns a Ruby code representation of this packet, such that
    # it can be eval'ed and sent later.
    #
    # rubocop:disable AbcSize
    # rubocop:disable MethodLength
    # rubocop:disable CyclomaticComplexity
    # rubocop:disable PerceivedComplexity
    def to_ruby
      pack_template = ''
      bytes = ''
      bit = false
      bit_names = []
      total_bit_length = 0
      field_names.each do |each|
        next unless __send__("#{each}?")
        if /Bit(\d+)$/ =~ __send__(each).class.to_s
          bit_length = Regexp.last_match(1).to_i
          total_bit_length += bit_length
          if bit
            bit_names << each
            bytes << format("_%0#{bit_length}b", __send__(each))
          else
            bit_names = [each]
            bytes << format("  0b%0#{bit_length}b", __send__(each))
          end
          bit = true
        else
          if bit
            bytes << ", # #{bit_names.join(', ')}\n"
            if total_bit_length == 8
              pack_template << 'C'
            elsif total_bit_length == 16
              pack_template << 'n'
            else
              raise
            end
            total_bit_length = 0
            bit_names = []
            bit = false
          end
          list = (@format || self).__send__(each).to_bytes
          next if list.empty?
          bytes << "  #{list}, # #{each}\n"
          pack_template << 'C' * (list.count(',') + 1)
        end
      end.compact

      template = ''
      until pack_template.empty?
        if /^(.)(\1+)/ =~ pack_template
          pack_template.sub!(/^(.)(\1+)/, '')
          template <<
            "#{Regexp.last_match(1)}#{Regexp.last_match(2).length + 1}"
        else
          pack_template.sub!(/^(.)/, '')
          template << Regexp.last_match(1)
        end
      end
      "[\n#{bytes}].pack('#{template}')"
    end
    # rubocop:enable AbcSize
    # rubocop:enable MethodLength
    # rubocop:enable CyclomaticComplexity
    # rubocop:enable PerceivedComplexity
  end
end
