require 'spec_helper'

describe Lita::Handlers::Bigtext, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }
  let(:response) { double('response') }

  before { stub_pastebin_calls! }

  context 'managing walls of text' do
    let(:longtext) { subject.longtext }

    it 'should generate a lot of words on demand' do
      expect(longtext.length > 512).to be_truthy
    end

    it 'should leverage the pastebin extension' do
      result = subject.snip_text(longtext)

      # only one phrase, not 100 words
      expect(result.split.length > 10).to be_falsey

      # stubbing out Faraday calls to hide from Pastebin API limits
      expect(result).to(
        match(%r{^https:\/\/pastebin\.com\/[a-zA-Z0-9]+})
      )
    end

    it 'should use pastebin extension when responding to users' do
      send_message 'Lita bigtext'
      expect(replies.last).to(
        match(%r{^https:\/\/pastebin\.com\/[a-zA-Z0-9]+})
      )
    end
  end
end
