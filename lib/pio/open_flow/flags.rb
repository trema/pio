# frozen_string_literal: true

module Pio
  module OpenFlow
    # bitmap functions.
    # This class smells of :reek:DataClump
    module Flags
      def define_flags_32bit(name, flags)
        _define_flags name, 32, flags
      end

      def flags_32bit(name, flags)
        _flags name, 32, flags
      end

      def flags_16bit(name, flags)
        _flags name, 16, flags
      end

      # rubocop:disable MethodLength
      # This method smells of :reek:TooManyStatements
      def _define_flags(name, size, flags)
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

        module_eval <<-end_eval, __FILE__, __LINE__
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
        end_eval
      end
      # rubocop:enable MethodLength

      def _flags(name, size, flags_)
        _define_flags name, size, flags_
        module_eval "#{name} :#{name}", __FILE__, __LINE__
      end
    end
  end
end
