require "method_arguments/inspector"

RSpec.describe MethodArguments::Inspector do
  subject {
    described_class.new(
      method(:example)
    )
  }

  describe "#parameters" do
    context "when method takes no args" do
      def example
      end

      it do
        expect(subject.parameters).to eq([])
      end
    end

    context "when has other args than key words args" do
      def example(a, b)
      end

      it do
        expect { subject.parameters }.to raise_error(MethodArguments::NonKeyArgsPresent)
      end
    end

    context "example with 3 keywords" do
      def example(a:, b:, c:)
      end

      it do
        expect(subject.parameters).to eq([:a, :b, :c])
      end
    end

    context "an example with an optional keyword" do
      def example(a:, b: nil)
      end

      it do
        expect(subject.parameters).to eq( [:b, :a])
        expect(subject.required_args).to eq([:a])
        expect(subject.optional_args).to eq([:b])
      end
    end
  end
end
