require 'spec_helper'

describe Lita::Handlers::Bigtext, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }
  let(:response) { double('response') }

  before do
    Faraday.stub(:post).and_return response
    response.stub(:success?).and_return true
    response.stub(:body).and_return 'fake body'
  end

  context 'managing walls of text' do
    let(:longtext) { subject.longtext }

    it 'should generate a lot of words on demand' do
      expect(longtext.length > 512).to be_truthy
    end

    it 'should leverage the pastebin extension' do
      expect(Faraday).to receive(:post)
      expect(response).to receive(:success?)
      expect(response).to receive(:body)

      result = subject.snip_text(longtext)

      # only one phrase, not 100 words
      expect(result.split.length > 10).to be_falsey

      # stubbing out Faraday calls to hide from Pastebin API limits
      expect(result).to eq('fake body')
    end
  end
end
