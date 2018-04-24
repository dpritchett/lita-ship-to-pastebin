require 'spec_helper'

describe Lita::Extensions::ShipToPastebin, lita: true do
  subject { Lita::Extensions::ShipToPastebin.new }

  it 'saves text to pastebin' do
    actual = subject.save_to_pastebin 'hey john', title: 'hey there john'
    expect(actual).to match(%r{https:\/\/pastebin/})
  end
end
