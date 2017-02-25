require "method_arguments/non_nil_for_required_args"

RSpec.describe MethodArguments::NonNilForRequiredArgs do
  class ExampleObject
    def example_method(value:, value2:)
      value * value2
    end
  end

  it "raises a type error when a required arg is given nil" do
    expect{described_class.new(ExampleObject.new).example_method(value: nil, value2: nil)}.to raise_error(MethodArguments::TypeError, "keywords value:, value2: cannot be nil!")
    expect{described_class.new(ExampleObject.new).example_method(value: nil, value2: 1)}.to raise_error(MethodArguments::TypeError, "keyword value: cannot be nil!")
  end

  it "filters out unneeded keywords args" do
    result = described_class.new(ExampleObject.new).example_method(value: 3, value2: 2, value3: nil)
    expect(result).to eq(6)
  end
end
