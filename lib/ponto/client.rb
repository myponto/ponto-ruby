module Ponto
  class Client

    attr_reader :base_uri, :client_id, :client_secret

    def initialize(token: nil, client_id: nil, client_secret: nil, api_scheme: "https", api_host: "api.myponto.com", api_port: "443", ssl_ca_file: nil)
      @token    = token
      @client_id = client_id
      @client_secret = client_secret
      @base_uri = "#{api_scheme}://#{api_host}:#{api_port}"
      @ssl_ca_file = ssl_ca_file
    end

    def get(uri:, query_params: {}, headers: nil, access_token: nil)
      headers = build_headers(access_token: access_token, extra_headers: headers)
      execute(method: :get, uri: uri, headers: headers, query_params: query_params)
    end

    def post(uri:, payload:, query_params: {}, headers: nil, access_token: nil)
      headers = build_headers(access_token: access_token, extra_headers: headers)
      execute(method: :post, uri: uri, headers: headers, query_params: query_params, payload: payload)
    end

    def patch(uri:, payload:, query_params: {}, access_token: nil)
      headers = build_headers(access_token: access_token)
      execute(method: :patch, uri: uri, headers: headers, query_params: query_params, payload: payload)
    end

    def delete(uri:, query_params: {}, access_token: nil, headers: nil)
      headers = build_headers(access_token: access_token, extra_headers: headers)
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
        payload:     payload && headers[:content_type] == :json ? payload.to_json : payload,
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

    def build_headers(access_token: nil, extra_headers: nil)
      headers = {
        content_type:  :json,
        accept:        :json,
      }
      headers[:authorization] = "Bearer #{access_token || @token}"
      headers.merge(extra_headers || {})
    end
  end
end
