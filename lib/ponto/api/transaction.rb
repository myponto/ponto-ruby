module Ponto
  class Transaction < Ponto::BaseResource
    def self.list(account_id:, headers: nil, **query_params)
      uri = Ponto.api_schema["account"]["transactions"]
        .sub("{accountId}", account_id)
        .sub("{transactionId}", "")
      list_by_uri(uri: uri, query_params: query_params, headers: headers)
    end

    def self.find(id:, account_id:)
      uri = Ponto.api_schema["account"]["transactions"]
        .sub("{accountId}", account_id)
        .sub("{transactionId}", id)
      find_by_uri(uri: uri)
    end
  end
end
