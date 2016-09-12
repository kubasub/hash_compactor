require_relative 'hash_compactor'
require 'byebug'

RSpec.describe HashCompactor do
  context "with a flat hash" do
    it "strips nil values" do
      hash = { a: nil }

      expect(described_class.compact(hash)).to eq({})
    end

    it "strips empty string values" do
      hash = { a: "" }

      expect(described_class.compact(hash)).to eq({})
    end

    it "strips empty hash values" do
      hash = { a: {} }

      expect(described_class.compact(hash)).to eq({})
    end

    it "strips empty arrays" do
      hash = { a: [] }

      expect(described_class.compact(hash)).to eq({})
    end

    it "does not strip non-empty arrays" do
      hash = { a: [1] }

      expect(described_class.compact(hash)).to eq(hash)
    end

    it "does not strip numbers" do
      hash = { a: 1 }

      expect(described_class.compact(hash)).to eq(a: 1)
    end
  end

  context "with a nested hash" do
    context "with one key with a nil value" do
      it "removes the nested hash" do
        hash = {
          a: { b: nil }
        }

        expect(described_class.compact(hash)).to eq({})
      end
    end

    context "with one key and an empty string value" do
      it "removes the nested hash" do
        hash = {
          a: { b: "" }
        }

        expect(described_class.compact(hash)).to eq({})
      end
    end

    context "with one key and an empty hash value" do
      it "removes the nested hash" do
        hash = {
          a: { b: {} }
        }

        expect(described_class.compact(hash)).to eq({})
      end
    end

    context "with one key and an empty array value" do
      it "removes the nested hash" do
        hash = {
          a: { b: [] }
        }

        expect(described_class.compact(hash)).to eq({})
      end
    end

    context "with one key and a numeric value" do
      it "does not strip the nested hash" do
        hash = {
          a: { b: 1 }
        }

        expect(described_class.compact(hash)).to eq(hash)
      end
    end

    context "with some values that should not be stripped" do
      it "correctly strips the nested hash" do
        hash = {
          a: {
            b: nil,
            c: 2,
            d: []
          }
        }

        expect(described_class.compact(hash)).to eq(a: { c: 2 })
      end
    end
  end
end
