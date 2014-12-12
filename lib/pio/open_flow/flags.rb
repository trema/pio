# bitmap functions.
module Flags
  def flags(name, flags)
    def_field name
    def_get name, flags
    def_set name, flags
  end

  def def_field(name)
    module_eval("uint32 :#{name}")
  end

  def def_get(name, flags)
    str = %{
      def get
        list = #{flags.inspect}
        list.each_with_object([]) do |(key, value), result|
          result << key if #{name} & value != 0
          result
        end
      end
    }
    module_eval str
  end

  def def_set(name, flags)
    str = %{
      def set(v)
        list = #{flags.inspect}
        v.each do |each|
          fail "Invalid state flag: \#{v}" unless list.keys.include?(each)
        end
        self.#{name} = v.map { |each| list[each] }.inject(:|)
      end
    }
    module_eval str
  end
end
