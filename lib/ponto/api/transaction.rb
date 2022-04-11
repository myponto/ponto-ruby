module Ponto
  class Transaction < Ponto::BaseResource
    def self.list(account_id: nil, synchronization_id: nil, access_token: nil, headers: nil, **query_params)
      uri = if synchronization_id
              Ponto.api_schema["synchronization"]["updatedTransactions"]
                .sub("{synchronizationId}", synchronization_id)
                .sub("{transactionId}", "")
            else
              Ponto.api_schema["account"]["transactions"]
                .sub("{accountId}", account_id)
                .sub("{transactionId}", "")
            end
      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.find(id:, access_token: nil, account_id:)
      uri = Ponto.api_schema["account"]["transactions"]
        .sub("{accountId}", account_id)
        .sub("{transactionId}", id)
      find_by_uri(uri: uri, access_token: access_token)
    end
  end
end
