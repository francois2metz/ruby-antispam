require 'spec_helper'

describe Cleantalk::SendFeedbackResult do
  let(:normal_response) do
    {
      "received" => 2,
      "comment" => "OK"
    }
  end

  it 'pass all result from JSON string' do
    instance = described_class.new(JSON.fast_generate(normal_response))

    normal_response.each do |key, value|
      expect(instance.send(key)).to eql(value)
    end
  end
end
