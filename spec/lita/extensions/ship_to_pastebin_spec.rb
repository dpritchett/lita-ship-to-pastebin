require 'pry'
require "spec_helper"

# TODO: require this instead somehow
load "lib/lita-bigtext.rb"

describe Lita::Extensions::ShipToPastebin, lita: true do
  # do the robot
  let(:robot) { Lita::Robot.new(registry) }
  let(:bigtexter) { Lita::Handlers::Bigtext.new(robot) }

  subject { Lita::Extensions::ShipToPastebin.new }

  it 'does a bigtext' do
    result = bigtexter.longtext

    expect(result).to match(/http/i)
  end

  it 'saves text to pastebin' do
    actual = subject.save_to_pastebin 'hey john', title: 'hey there john'
    expect(actual).to match /https:\/\/pastebin/
  end
end
