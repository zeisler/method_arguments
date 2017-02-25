require "spec_helper"

describe MethodArguments do
  it "has a version number" do
    expect(MethodArguments::VERSION).not_to be nil
  end

  class ExampleObject
    def example_method(arg:)
      arg * 10
    end
  end

  describe ".new" do
    it "take an object and delegates methods to it" do
      result = described_class.new(ExampleObject.new).example_method(arg: 1)
      expect(result).to eq(10)
    end

    it "filters out unneeded keywords args" do
      result = described_class.new(ExampleObject.new).example_method(arg: 3, arg2: 2)
      expect(result).to eq(30)
    end
  end
end
