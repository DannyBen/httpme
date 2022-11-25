require 'spec_helper'

describe Command do
  context 'without arguments' do
    let(:default_options) { { path: '.', port: 3000, host: '0.0.0.0', auth: nil } }

    it 'runs the server with default options' do
      expect(Server).to receive(:setup).with(default_options)
      expect(Server).to receive(:run!)
      subject.execute
    end
  end

  context 'with options' do
    let(:options) { { path: 'spec', port: 4000, host: '127.0.0.1', auth: 'me:secret' } }

    it 'runs the server with requested options' do
      expect(Server).to receive(:setup).with(options)
      expect(Server).to receive(:run!)
      subject.execute %w[spec --port 4000 --host 127.0.0.1 --auth me:secret]
    end
  end

  context 'with environment variables' do
    let(:options) { { path: 'spec', port: 4000, host: '127.0.0.1', auth: 'me:secret' } }

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

    it 'runs the server with requested options' do
      expect(Server).to receive(:setup).with(options)
      expect(Server).to receive(:run!)
      subject.execute
    end
  end

  context 'with invalid path' do
    it 'raises an error' do
      expect { subject.execute %w[invalid-path] }
        .to raise_error(ArgumentError, 'Path not found [invalid-path]')
    end
  end

  context 'with --help' do
    it 'shows long usage' do
      expect { subject.execute %w[--help] }.to output_approval('command/help')
    end
  end
end
