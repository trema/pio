# bitmap functions.
module Flags
  # rubocop:disable MethodLength
  def flags(name, *flags_array, **flags_hash)
    flags = if flags_hash.empty?
              flags_with_value = flags_array.map do |each|
                [each, 1 << flags_array.index(each)]
              end
              Hash[flags_with_value]
            else
              flags_hash
            end
    def_class_list flags
    def_field name
    def_get name, flags
    def_set name, flags
  end
  # rubocop:enable MethodLength

  def def_class_list(flags)
    str = %(
      def self.list
        #{flags.keys.inspect}
      end
    )
    module_eval str
  end

  def def_field(name)
    module_eval("uint32 :#{name}")
  end

  def def_get(name, list)
    str = %{
      def get
        list = #{list.inspect}
        list.each_with_object([]) do |(key, value), result|
          result << key if #{name} & value != 0
          result
        end
      end
    }
    module_eval str
  end

  def def_set(name, list)
    str = %{
      def set(v)
        list = #{list.inspect}
        v.each do |each|
          fail "Invalid state flag: \#{v}" unless list.keys.include?(each)
        end
        self.#{name} = v.map { |each| list[each] }.inject(:|)
      end
    }
    module_eval str
  end
end
