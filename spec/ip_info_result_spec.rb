require 'spec_helper'

describe Cleantalk::IpInfoResult do
  let(:normal_response) do
    {
      "data" => {
        "8.8.8.8" => {
          "country_code" => "US",
          "country_name" => "United States"
        }
      }
    }
  end

  let(:error_response) do
    {
      "error_message" => "Calls limit exceeded.",
      "error_no" => 10
    }
  end

  it 'pass all result from JSON string' do
    instance = described_class.new(JSON.fast_generate(normal_response))

    normal_response.each do |key, value|
      expect(instance.send(key)).to eql(value)
    end
  end

  it 'handle errors' do
    instance = described_class.new(JSON.fast_generate(error_response))
    error_response.each do |key, value|
      expect(instance.send(key)).to eql(value)
    end
  end
end
