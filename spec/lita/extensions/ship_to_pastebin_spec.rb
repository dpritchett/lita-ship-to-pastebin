require "spec_helper"

describe Lita::Extensions::ShipToPastebin, lita: true do
  subject { Lita::Extensions::ShipToPastebin.new }

  it 'works' do
    canary = 'JOHN DOT MEM'
    actual = subject.hi canary
    expect(actual).to eq canary
  end

  it 'saves text to pastebin' do
    actual = subject.save_to_pastebin 'hey john', title: 'hey there john'
    expect(actual).to match /https:\/\/pastebin/
  end
end
