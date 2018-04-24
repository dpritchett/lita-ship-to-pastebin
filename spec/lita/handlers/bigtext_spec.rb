require 'spec_helper'

describe Lita::Handlers::Bigtext, lita_handler: true do
  let(:robot) { Lita::Robot.new(registry) }
  let(:response) { double('response') }

  before do
    Faraday.stub(:post).and_return response
    response.stub(:success?).and_return true
    response.stub(:body).and_return 'fake body'
  end

  it 'should leverage the pastebin extension' do
    expect(Faraday).to receive(:post)
    expect(response).to receive(:success?)
    expect(response).to receive(:body)

    result = subject.longtext

    # only one phrase, not 100 words
    expect(result.split.length > 10).to be_falsey

    # beware pastebin api rate limit
    expect(result).to eq('fake body')
  end
end
