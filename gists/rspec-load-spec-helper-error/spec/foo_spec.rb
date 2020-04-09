# frozen_string_literal: true

RSpec.describe Foo do
  it do
    expect(described_class.new.foo).to eq("Foo")
  end
end
