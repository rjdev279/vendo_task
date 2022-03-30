# frozen_string_literal: true

require 'json'
require 'net/http'
require_relative 'cart'
require_relative '../utilities/api_exceptions'
require_relative '../utilities/request'
require_relative '../utilities/response'
# SpreeCommerceAPI Client
module Api
  module SpreeCommerce
    class Client
      include Cart
      include ApiExceptions
      include Request
      include Response

      def request(action, path, params = {}, token = nil)
        uri = URI "#{ENV['BASE_URL']}/#{path}"
        uri.query = URI.encode_www_form(params)
        request = http_namespace(action).new(uri)
        headers(request, token)
        request_response = http_response(request, true)
        response = request_response.value || request_response
        parsed_response(response)
      rescue *error_class(request_response) => e
        { 'error' => "#{e.class}: #{e.message}" }
      end

      private

      def headers(request, token)
        request['Content-Type'] = 'application/vnd.api+json'
        request['X-Spree-Order-Token'] = token unless token.nil?
      end

      def parsed_response(response)
        response ? JSON.parse(response.body) : {}
      end
    end
  end
end
