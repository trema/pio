module Pio
  # User options utility.
  class Options
    def self.mandatory_option(name)
      if const_defined?(:MANDATORY_OPTIONS)
        const_get(:MANDATORY_OPTIONS) << name
      else
        const_set(:MANDATORY_OPTIONS, [name])
      end
    end

    def self.option(name)
      const_set(:OPTIONS, []) unless const_defined?(:OPTIONS)
      const_get(:OPTIONS) << name
    end

    private

    def validate(user_options)
      check_unknown user_options
      check_mandatory user_options
    end

    def mandatory_options
      klass = self.class
      if klass.const_defined?(:MANDATORY_OPTIONS)
        klass.const_get(:MANDATORY_OPTIONS)
      else
        []
      end
    end

    def options
      klass = self.class
      if klass.const_defined?(:OPTIONS)
        klass.const_get(:OPTIONS)
      else
        []
      end
    end

    def check_unknown(user_options)
      valid_options = mandatory_options + options
      user_options.keys.each do |each|
        fail "Unknown option: #{each}." unless valid_options.include?(each)
      end
    end

    def check_mandatory(user_options)
      self.class.const_get(:MANDATORY_OPTIONS).each do |each|
        check_existence(user_options, each)
      end
    end

    def check_existence(user_options, key)
      value = user_options.fetch(key) do |missing_key|
        fail ArgumentError, "The #{missing_key} option should be passed."
      end
      return if value
      fail(ArgumentError, "The #{key} option shouldn't be #{value.inspect}.")
    end
  end
end
