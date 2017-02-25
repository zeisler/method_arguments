require "method_arguments/satisfier"

RSpec.describe MethodArguments::Satisfier do
  subject {
    described_class.new(
      possible_args: possible_args,
      method_proc:   method(:example)
    )
  }

  describe "#args" do
    let(:possible_args) {
      {
        a: 1,
        b: 2,
        c: 3
      }
    }
    context "when method takes no args" do
      def example
      end

      it do
        expect(subject.parameters).to eq({})
        subject.call
      end
    end

    context "when has other args than key words args" do
      def example(a, b)
      end

      it do
        expect { subject.parameters }.to raise_error(MethodArguments::NonKeyArgsPresent)
      end
    end

    context "when method takes all args" do
      def example(a:, b:, c:)
      end

      it do
        expect(subject.parameters).to eq(possible_args)
        subject.call
      end
    end

    context "when method takes some args" do
      def example(a:, b: nil)
      end

      it do
        expect(subject.parameters).to eq(:a => 1, :b => 2)
        expect(subject.required_args).to eq(:a => 1)
        expect(subject.optional_args).to eq(:b => 2)
        subject.call
      end
    end

    context "when possible_args does not included needed value" do
      subject {
        described_class.new(
          possible_args: possible_args,
          method_proc:   method(:example),
        )
      }

      def example(a:, b:)
      end

      let(:possible_args) {
        {
          a: 1
        }
      }

      it "only return the values in the source list of possible_args" do
        expect(subject.parameters).to eq(a: 1)
      end
    end
  end
end
