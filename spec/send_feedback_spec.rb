require 'spec_helper'

describe Cleantalk::SendFeedback do
  let :base_parameters do
    { method_name: "send_feedback", auth_key: 'test', feedback: [["requestid1", 1], ["requestid2", 0]] }
  end

  let :request do
    described_class.new(base_parameters)
  end

  it 'create a request' do
    request.auth_key = 'test'
    expect(request.auth_key).to eql('test')
    expect(request.feedback).to eql([["requestid1", 1], ["requestid2", 0]])
    expect(request.is_a? Cleantalk::Request).to be true
    expect(request.method_name).to eql("send_feedback")
  end

  let(:res_body) {  {"data":{"8.8.8.8":{"country_code":"US","country_name":"United States"}}} }

  it 'perform the request and return the result' do
    stub_request(:post, "https://moderate.cleantalk.org:443/api2.0")
      .with(body: JSON.fast_generate({ method_name: "send_feedback", auth_key: 'test', feedback: "requestid1:1;requestid2:0" }))
      .to_return(status: 200, body: JSON.dump(res_body), headers: {})

    expect_any_instance_of(described_class).to receive(:http_request_without_parse).once.and_call_original
    expect(request.result.is_a? Cleantalk::SendFeedbackResult).to be true
    expect(request.result.is_a? Cleantalk::SendFeedbackResult).to be true
  end
end
