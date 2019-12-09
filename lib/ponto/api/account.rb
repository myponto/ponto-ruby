module Ponto
  class Account < Ponto::BaseResource
    def self.list(headers: nil, access_token: nil, **query_params)
      uri = Ponto.api_schema["accounts"].sub("{accountId}", "")
      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.find(id:, access_token: nil, headers: nil)
      uri = Ponto.api_schema["accounts"].sub("{accountId}", id)
      find_by_uri(uri: uri, headers: headers, access_token: access_token)
    end
  end
end
