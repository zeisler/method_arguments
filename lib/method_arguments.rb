require "method_arguments/version"
require "method_arguments/inspector"
require "method_arguments/satisfier"
require "method_arguments/base"

module MethodArguments
  def self.new(obj)
    Base.new(obj)
  end
end
