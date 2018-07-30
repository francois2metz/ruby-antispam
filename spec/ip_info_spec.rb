require 'spec_helper'

describe Cleantalk::IpInfo do
  let :base_parameters do
    { method_name: "ip_info", auth_key: 'test', ip: '8.8.8.8' }
  end

  let :request do
    described_class.new(base_parameters)
  end

  it 'create a request' do
    request.auth_key = 'test'
    expect(request.auth_key).to eql('test')
    expect(request.ip).to eql('8.8.8.8')
    expect(request.is_a? Cleantalk::Request).to be true
    expect(request.method_name).to eql("ip_info")
  end

  let(:res_body) {  {"data":{"8.8.8.8":{"country_code":"US","country_name":"United States"}}} }

  it 'perform the request and return the result' do
    stub_request(:get, "https://api.cleantalk.org:443/?method_name=ip_info&ip=8.8.8.8")
      .to_return(status: 200, body: JSON.dump(res_body), headers: {})
    expect_any_instance_of(described_class).to receive(:http_request_without_parse).once.and_call_original
    expect(request.result.is_a? Cleantalk::IpInfoResult).to be true
    expect(request.result.is_a? Cleantalk::IpInfoResult).to be true
  end
end
