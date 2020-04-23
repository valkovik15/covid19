# frozen_string_literal: true

require 'net/http'
require 'net/https'
require 'rubygems'
require 'open-uri'
require 'covid19/errors'

module Covid19
  # Module to handle HTTP connection setup and usage
  module Request
    def get(path, data = {}, content_type = 'application/json')
      raise Covid19::APIKeyError, 'API key not configured for client' unless key

      request(:get, path, data, content_type)
    end

    private
    def request(method, path, data, content_type)
      path += hash_to_query_string(data) if %i[delete get].include? method
      uri = URI.parse ['https://', host, path].join
      request_class = Net::HTTP.const_get method.to_s.capitalize
      response = setup_connection(uri).request request_with_headers(request_class, uri, content_type)
      response_body(response)
    end

    def request_with_headers(request_class, uri, content_type)
      request = request_class.new uri.request_uri
      request.add_field 'X-RapidAPI-Host', host
      request.add_field 'X-RapidAPI-Key', key
      request.add_field 'User-Agent', user_agent
      request.content_type = content_type
      request
    end

    def setup_connection(uri)
      proxy = uri.find_proxy
      @connection = if proxy
        Net::HTTP::Proxy(proxy.host, proxy.port, proxy.user, proxy.password).new(uri.host, uri.port)
      else
        Net::HTTP.new uri.host, uri.port
      end
      @connection.read_timeout = 10
      @connection.use_ssl = true
      @connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @connection.start
    end

    def hash_to_query_string(hash)
      return '' if hash.empty?

      '?' + URI.encode_www_form(hash)
    end

    def response_body(response)
      case response
      when Net::HTTPNotFound
        raise Covid19::NotFoundError, response.body
      when Net::HTTPSuccess
        response.body
      else
        raise Covid19::APICallError, response.body
      end
    end
  end
end
