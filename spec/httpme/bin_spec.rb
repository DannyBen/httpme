require 'spec_helper'

describe 'bin/httpme' do
  context 'when an exception occurs' do
    it 'errors gracefully' do
      expect(`bin/httpme some-invalid-path 2>&1`).to match_approval('cli/exception')
    end
  end
end
