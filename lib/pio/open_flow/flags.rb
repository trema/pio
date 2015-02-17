module Pio
  module OpenFlow
    # bitmap functions.
    # This class smells of :reek:DataClump
    module Flags
      def flags_32bit(name, flags)
        _def_flags name, 32, flags
      end

      def flags_16bit(name, flags)
        _def_flags name, 16, flags
      end

      # rubocop:disable MethodLength
      # This method smells of :reek:TooManyStatements
      def _def_flags(name, size, flags)
        flag_value = case flags
                     when Array
                       shift = 0
                       flags.each_with_object({}) do |each, result|
                         result[each] = 1 << shift
                         shift += 1
                         result
                       end
                     when Hash
                       flags
                     end

        klass_name = name.to_s.split('_').map(&:capitalize).join
        flags_hash = flag_value.inspect

        code = %{
          class #{klass_name} < BinData::Primitive
            endian :big

            uint#{size} :#{name}

            def get
              list = #{flags_hash}
              list.each_with_object([]) do |(key, value), result|
                result << key if #{name} & value != 0
                result
              end
            end

            def set(v)
              list = #{flags_hash}
              v.each do |each|
                fail "Invalid state flag: \#{v}" unless list.keys.include?(each)
              end
              self.#{name} = v.empty? ?
                             0 :
                             v.map { |each| list[each] }.inject(:|)
            end
          end
        }
        module_eval code
      end
    end
  end
end
