require "method_arguments/inspector"

module MethodArguments
  class Satisfier
    # @param [Hash] possible_args
    # @param [Method] method_proc
    def initialize(possible_args:, method_proc:)
      @possible_args = possible_args
      @method_proc   = method_proc
    end

    def parameters
      build_hash(__method__)
    end

    def required_args
      build_hash(__method__)
    end

    def optional_args
      build_hash(__method__)
    end

    def call
      if parameters.empty?
        method_proc.call
      else
        method_proc.call(parameters)
      end
    end

    private
    attr_reader :method_proc, :possible_args

    def build_hash(type)
      method_keywords_inspector.public_send(type).each_with_object({}) do |keyword, hash|
        assign(hash, keyword)
      end
    end

    def assign(hash, keyword)
      hash[keyword] = possible_args[keyword] if possible_args.key?(keyword)
    end

    def method_keywords_inspector
      @method_keywords_inspector ||= Inspector.new(method_proc)
    end
  end
end
