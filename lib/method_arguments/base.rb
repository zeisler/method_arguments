require "method_arguments/satisfier"

module MethodArguments
  class Base
    def initialize(obj)
      @obj = obj
    end

    def method_missing(meth, **args)
      if @obj.respond_to?(meth)
        Satisfier.new(method_proc: @obj.method(meth), possible_args: args).call
      else
        @obj.send(meth, *args, &block)
      end
    end
  end
end
