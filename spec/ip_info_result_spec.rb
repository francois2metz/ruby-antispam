require 'spec_helper'

describe Cleantalk::IpInfoResult do
  let :init_values do
    {
      "data" => {
        "8.8.8.8" => {
          "country_code" => "US",
          "country_name" => "United States"
        }
      }
    }
  end

  it 'pass all result from JSON string' do
    instance = described_class.new(JSON.fast_generate(init_values))

    init_values.each do |key, value|
      expect(instance.send(key)).to eql(value)
    end
  end
end
