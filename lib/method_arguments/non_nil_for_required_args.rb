require "method_arguments/satisfier"

module MethodArguments
  TypeError = Class.new(::TypeError)
  class NonNilForRequiredArgs
    def initialize(obj)
      @obj = obj
    end

    def method_missing(meth, **args)
      if @obj.respond_to?(meth)
        satisfier = Satisfier.new(method_proc: @obj.method(meth), possible_args: args)
        __check_for_nil!(satisfier)
        satisfier.call
      else
        @obj.send(meth, *args, &block)
      end
    end

    private

    def __check_for_nil!(satisfier)
      nil_values_for_required = satisfier.required_args.select { |_, v| v.nil? }
      return if nil_values_for_required.empty?
      keyword = "keyword#{nil_values_for_required.keys.count > 1 ? "s" : ""}"
      keys    = nil_values_for_required.keys.map { |k| "#{k}:" }.join(", ")
      raise TypeError, "#{keyword} #{keys} cannot be nil!"
    end
  end
end
