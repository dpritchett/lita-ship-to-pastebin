require "spec_helper"

describe Lita::Extensions::ShipToPastebin, lita: true do
  subject { Lita::Extensions::ShipToPastebin.new }

  it 'works' do
    canary = 'JOHN DOT MEM'
    actual = subject.hi canary
    expect(actual).to eq canary
  end

  it 'does a barrel roll' do
    canary = 'idk'
    actual = subject.do_a_barrel_roll

    expect(1).to eq 2
  end
end
