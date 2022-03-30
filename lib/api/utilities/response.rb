# frozen_string_literal: true

module Response
  def http_response(request, is_secure=true)
    Net::HTTP.start(request.uri.host, request.uri.port, { use_ssl: is_secure }) do |http|
      http.request(request)
    end
  end
end
