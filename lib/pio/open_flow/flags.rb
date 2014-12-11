# encoding: utf-8

# bitmap functions.
module Flags
  def flags(name, *flags)
    def_class_list flags
    def_field name
    def_get name, flags
    def_set name, flags
  end

  def def_class_list(flags)
    str = %(
      def self.list
        #{flags.inspect}
      end
    )
    module_eval str
  end

  def def_field(name)
    module_eval("uint32 :#{name}")
  end

  # rubocop:disable MethodLength
  def def_get(name, list)
    str = %{
      def get
        list = #{list.inspect}
        case list
        when Hash
          list.each_with_object([]) do |(key, value), result|
            result << key if #{name} & value != 0
            result
          end
        when Array
          (0..(list.length - 1)).each_with_object([]) do |each, result|
            result << list[each] if #{name} & (1 << each) != 0
            result
          end
        end
      end
    }
    module_eval str
  end

  def def_set(name, list)
    str = %{
      def set(v)
        list = #{list.inspect}
        case list
        when Hash
          v.each do |each|
            fail "Invalid state flag: \#{v}" unless list.keys.include?(each)
          end
          self.#{name} = v.map { |each| list[each] }.inject(:|)
        when Array
          v.each do |each|
            fail "Invalid #{name} flag: \#{v}" unless list.include?(each)
          end
          self.#{name} = v.map { |each| 1 << list.index(each) }.inject(:|)
        end
      end
    }
    module_eval str
  end
  # rubocop:enable MethodLength
end
