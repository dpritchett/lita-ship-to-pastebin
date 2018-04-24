require 'webmock/rspec'
require 'spec_helper'

describe Lita::Extensions::ShipToPastebin, lita: true do
  subject { Lita::Extensions::ShipToPastebin.new }

  before { stub_pastebin_calls! }

  it 'saves text to pastebin' do
    actual = subject.save_to_pastebin 'hey john', title: 'hey there john'
    expect(actual).to include('https://pastebin.com/')
  end
end
