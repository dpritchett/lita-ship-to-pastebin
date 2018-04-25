require 'spec_helper'

describe Lita::Extensions::ShipToPastebin, lita: true do
  subject { Lita::Extensions::ShipToPastebin.new }

  # thanks webmock!
  before { stub_pastebin_calls! }

  it 'saves text to pastebin' do
    actual = subject.save_to_pastebin 'hey john', title: 'hey there john'

    # e.g. https://pastebin.com/Vi4Cgn6i
    expect(actual).to match(%r{^https:\/\/pastebin\.com\/[a-zA-Z0-9]+})
  end
end
