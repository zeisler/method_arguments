module MethodArguments
  NonKeyArgsPresent = Class.new(StandardError)

  class Inspector
    # @param [Method] method_proc
    def initialize(method_proc)
      @method_proc = method_proc
    end

    def parameters
      [*used_keywords[:key], *used_keywords[:keyreq]]
    end

    def required_args
      used_keywords[:keyreq]
    end

    def optional_args
      used_keywords[:key]
    end

    def call(parameters)
      method_proc.call(parameters)
    end

    private
    attr_reader :method_proc

    def used_keywords
      @used_keywords ||= method_proc.parameters.each_with_object({ key: [], keyreq: [] }) do |(key, name), hash|
        next if key == :rest
        raise NonKeyArgsPresent, "#{method_proc.inspect} - #{name} must be a keyword arg" unless [:key, :keyreq].include?(key)
        hash[key] << name
      end
    end
  end
end
