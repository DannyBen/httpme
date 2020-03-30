require 'spec_helper'

describe Command do
  subject { CLI.router }
  let(:mock_server) { Class.new { def run; end }.new }

  context "without arguments" do
    let(:default_options) {{ path: '.', port: 3000, host: '0.0.0.0', auth: nil }}

    it "runs the server with default options" do
      expect(Server).to receive(:new).with(default_options).and_return mock_server
      expect(mock_server).to receive(:run)
      subject.run
    end
  end

  context "with options" do
    let(:options) {{ path: 'spec', port: 4000, host: '127.0.0.1', auth: 'me:secret' }}

    it "runs the server with requested options" do
      expect(Server).to receive(:new).with(options).and_return mock_server
      expect(mock_server).to receive(:run)
      subject.run %w[spec --port 4000 --host 127.0.0.1 --auth me:secret]
    end
  end

  context "with environment variables" do
    let(:options) {{ path: 'spec', port: 4000, host: '127.0.0.1', auth: 'me:secret' }}
    
    before do
      ENV['HTTPME_PATH'] = 'spec'
      ENV['HTTPME_PORT'] = '4000'
      ENV['HTTPME_HOST'] = '127.0.0.1'
      ENV['HTTPME_AUTH'] = 'me:secret'
    end

    after do
      %w[HTTPME_PATH HTTPME_PORT HTTPME_HOST HTTPME_AUTH].each do |var|
        ENV.delete var
      end
    end

    it "runs the server with requested options" do
      expect(Server).to receive(:new).with(options).and_return mock_server
      expect(mock_server).to receive(:run)
      subject.run
    end
  end

  context "with invalid path" do
    it "raises an error" do
      expect { subject.run %w[invalid-path] }.to raise_error(ArgumentError, "Path not found [invalid-path]")
    end
  end

  context "with --help" do
    it "shows long usage" do
      expect { subject.run %w[--help] }.to output_fixture('command/help')
    end
  end
end
