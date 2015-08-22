require_relative '../spec_helper'

describe RubyNosClient::Config do
  let(:config) { described_class.new }

  describe '#server' do
    it 'has a port which defaults to 10100' do
      expect(described_class.port).to eq(10100)
    end
  end

  describe '#api' do
    it 'has an api prefix which defaults is ""' do
      expect(described_class.prefix).to eq("")
    end
  end
end