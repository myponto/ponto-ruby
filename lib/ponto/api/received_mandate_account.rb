module Ponto
  class ReceivedMandateAccount < Ponto::BaseResource
    def self.find(mandate_id:, account_id:, access_token: nil, headers: nil)
      uri = Ponto.api_schema["receivedMandate"]["accounts"]
      .sub("{mandateId}", mandate_id)
      .sub("{accountId}", account_id)
      puts uri
      find_by_uri(uri: uri, headers: headers, access_token: access_token)
    end

    def self.list(mandate_id:, access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["receivedMandate"]["accounts"]
      .sub("{mandateId}", mandate_id)
      .sub("{accountId}", "")
      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end
  end
end