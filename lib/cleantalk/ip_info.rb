class Cleantalk::IpInfo < Cleantalk::Request
  attr_accessor :ip

  def result
    @result ||= Cleantalk::IpInfoResult.new(http_request_without_parse)
  end

  def http_request_without_parse
    params = { ip: ip, method_name: METHOD }
    uri = API_URI.dup
    uri.query = URI.encode_www_form(params)
    req = Net::HTTP::Get.new(uri, API_HEADERS)
    response = Net::HTTP.start(API_URI.hostname, API_URI.port, use_ssl: true) do |http|
      http.request(req)
    end

    response.entity
  end


  METHOD = "ip_info".freeze
  API_URI = URI.parse('https://api.cleantalk.org/').freeze
end
