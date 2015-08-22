require_relative '../spec_helper'

describe RubyNosClient::Cli do
  let(:cli){ RubyNosClient::Cli.new }
  describe '.test' do
    it 'runs the RSpec suite' do
      expect(RSpec::Core::Runner).to receive(:run).with(['spec'])
      cli.test
    end
  end

  describe '.start' do
    it 'starts the App' do
      expect(RubyNosClient::App).to receive(:start!)
      cli.start
    end
  end

  describe '.console' do
    let(:cli_binding){ double('cli_binding', :pry => nil) }
    before(:each){ allow(cli).to receive(:binding){ cli_binding } }

    it 'launches Pry' do
      expect(cli_binding).to receive(:pry)
      cli.console
    end
  end
end

