require 'spec_helper'

describe 'bin/httpme' do
  context "on exception" do
    it "errors gracefuly" do
      expect(`bin/httpme some-invalid-path 2>&1`).to match_fixture('cli/exception')
    end
  end
end
