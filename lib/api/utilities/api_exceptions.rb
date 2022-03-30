# frozen_string_literal: true
require_relative 'http_status_codes'
module ApiExceptions
  include HttpStatusCodes

  ARGUMENT_ERROR = ArgumentError
  RUNTIME_ERROR = RuntimeError
  TYPE_ERROR = TypeError
  PARSER_ERROR = JSON::ParserError
  HTTP_EXCEPTION = Net::HTTPClientException

  def error_class(response)
    case response.code
    when HTTP_BAD_REQUEST_CODE
      ARGUMENT_ERROR
    when HTTP_INTERNAL_SERVER_ERROR
      TYPE_ERROR
    when HTTP_PARSED_RESPONSE_CODE
      PARSER_ERROR
    when HTTP_NOT_FOUND_CODE
      HTTP_EXCEPTION
    else
      RUNTIME_ERROR
    end
  end
end
