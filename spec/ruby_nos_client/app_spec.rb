require_relative '../spec_helper'
require 'puma/cli'

describe RubyNosClient::App do
  let(:app){ Class.new(described_class) }

  describe '.start' do
    let(:server){ double(:server, run: nil) }
    before(:each){ allow(Puma::CLI).to receive(:new){ server } }

    it 'boots puma' do
      expect(Puma::CLI).to receive(:new).with(['-p', '10100']).and_return(server)
      app.run
    end
  end
end
