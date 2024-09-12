module Ponto
  class User < Ponto::BaseResource
    def self.list(access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["users"]
      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end
  end
end