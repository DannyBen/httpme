require 'spec_helper'

describe Server do
  let(:path) { 'spec/fixtures/docroot' }
  let(:options) { { path: path } }

  let(:app) do
    server = HTTPMe::Server.new options
    server.app
  end

  describe '#run' do
    it "starts puma" do
      expect(Rack::Handler::Puma).to receive(:run)
      subject.run
    end
  end

  describe '#app' do
    it "works" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /<h1>Success/
    end

    it "serves nested index.html files" do
      get '/subdir/'
      expect(last_response).to be_ok
      expect(last_response.body).to match /<h1>Nested file also works/
    end

    context "with auth parameter" do
      let(:options) { { path: path, auth: 'admin:s3cr3t' } }

      context "when unauthorized" do
        it "blocks access" do
          get '/'
          expect(last_response).to be_unauthorized
        end
      end

      context "when authorized" do
        before { basic_authorize 'admin', 's3cr3t' }

        it "allows access" do
          get '/'
          expect(last_response).to be_ok
          expect(last_response.body).to match /<h1>Success/
        end
      end
    end
  end

end
