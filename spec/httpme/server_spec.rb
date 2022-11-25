require 'spec_helper'

describe Server do
  let(:path) { 'spec/fixtures/docroot' }
  let(:auth) { nil }
  let(:app) { described_class.setup path: path, auth: auth }

  describe '#app' do
    it 'is successful' do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to match(/<h1>Success/)
    end

    context 'with a path ending with /' do
      it 'serves nested index.html files' do
        get '/subdir/'
        expect(last_response).to be_ok
        expect(last_response.body).to match(/<h1>Nested file also works/)
      end
    end

    context 'when the path is a directory but does not end with /' do
      it 'serves nested index.html files' do
        get '/subdir'
        expect(last_response).to be_ok
        expect(last_response.body).to match(/<h1>Nested file also works/)
      end
    end

    context 'when the path is not found' do
      it 'shows a 404 Not Found' do
        get '/notfound'
        expect(last_response).to be_not_found
        expect(last_response.body).to eq '404 Not Found'
      end
    end

    context 'when the path is a directory without index.html' do
      it 'shows a 404 Not Found' do
        get '/css/'
        expect(last_response).to be_not_found
        expect(last_response.body).to eq '404 Not Found'
      end
    end

    context 'when auth is configured' do
      let(:auth) { 'admin:s3cr3t' }

      context 'when unauthorized' do
        it 'blocks access' do
          get '/'
          expect(last_response).to be_unauthorized
        end
      end

      context 'when authorized' do
        before { basic_authorize 'admin', 's3cr3t' }

        it 'allows access' do
          get '/'
          expect(last_response).to be_ok
          expect(last_response.body).to match(/<h1>Success/)
        end
      end
    end
  end
end
