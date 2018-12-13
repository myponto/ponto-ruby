module Ponto
  class Account < Ponto::BaseResource
    def self.list(headers: nil, **query_params)
      uri = Ponto.api_schema["accounts"].sub("{accountId}", "")
      list_by_uri(uri: uri, query_params: query_params, headers: headers)
    end

    def self.find(id:, headers: nil)
      uri = Ponto.api_schema["accounts"].sub("{accountId}", id)
      find_by_uri(uri: uri, headers: headers)
    end
  end
end
