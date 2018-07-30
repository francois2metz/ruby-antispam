class Cleantalk::SendFeedback < Cleantalk::Request
  attr_accessor :feedback

  def result
    @result ||= Cleantalk::SendFeedbackResult.new(http_request_without_parse)
  end

  def http_request_without_parse
    valid?
    form_data = { method_name: METHOD, auth_key: auth_key, feedback: feedback.map {|a| a.join(':') }.join(';') }
    req = Net::HTTP::Post.new(API_URI, API_HEADERS)
    req.body = JSON.generate(form_data)
    response = Net::HTTP.start(API_URI.hostname, API_URI.port, use_ssl: true) do |http|
      http.request(req)
    end

    response.entity
  end


  METHOD = "send_feedback".freeze
end
