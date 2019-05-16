module Ponto
  class Client

    attr_reader :base_uri

    def initialize(token:, api_scheme: "https", api_host: "api.myponto.com", api_port: "443", ssl_ca_file: nil)
      @token    = token
      @base_uri = "#{api_scheme}://#{api_host}:#{api_port}"
      @ssl_ca_file = ssl_ca_file
    end

    def get(uri:, query_params: {}, headers: nil)
      headers = build_headers(extra_headers: headers)
      execute(method: :get, uri: uri, headers: headers, query_params: query_params)
    end

    def post(uri:, payload:, query_params: {})
      headers = build_headers()
      execute(method: :post, uri: uri, headers: headers, query_params: query_params, payload: payload)
    end

    def patch(uri:, payload:, query_params: {})
      headers = build_headers()
      execute(method: :patch, uri: uri, headers: headers, query_params: query_params, payload: payload)
    end

    def delete(uri:, query_params: {})
      headers = build_headers()
      execute(method: :delete, uri: uri, headers: headers, query_params: query_params)
    end

    def build_uri(path)
      URI.join(@base_uri, path).to_s
    end

    private

    def execute(method:, uri:, headers:, query_params: {}, payload: nil)
      query = {
        method:      method,
        url:         uri,
        headers:     headers.merge(params: query_params),
        payload:     payload ? payload.to_json : nil,
        ssl_ca_file: @ssl_ca_file
      }
      raw_response = RestClient::Request.execute(query) do |response, request, result, &block|
        if response.code >= 400
          body = JSON.parse(response.body)
          raise Ponto::Error.new(body["errors"]), "Ponto request failed."
        else
          response.return!(&block)
        end
      end
      JSON.parse(raw_response)
    end

    def build_headers(extra_headers: nil)
      headers = {
        content_type:  :json,
        accept:        :json,
      }
      headers["Authorization"] = "Bearer #{@token}"
      if extra_headers.nil?
        headers
      else
        extra_headers.merge(headers)
      end
    end
  end
end
