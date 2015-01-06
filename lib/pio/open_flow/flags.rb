# bitmap functions.
module Flags
  # rubocop:disable MethodLength
  # This method smells of :reek:TooManyStatements
  def def_flags(name, flags)
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
    _def_class name, flag_value
  end
  # rubocop:enable MethodLength

  # rubocop:disable MethodLength
  def _def_class(name, flags)
    klass_name = name.to_s.split('_').map(&:capitalize).join
    flags_hash = flags.inspect

    code = %{
      class #{klass_name} < BinData::Primitive
        endian :big

        uint32 :#{name}

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
          self.#{name} = v.empty? ? 0 : v.map { |each| list[each] }.inject(:|)
        end
      end
    }
    module_eval code
  end
  # rubocop:enable MethodLength
end
