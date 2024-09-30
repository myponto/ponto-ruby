module Ponto
  class GivenMandateAccount < Ponto::BaseResource
    def self.list(mandate_id:, access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["givenMandate"]["accounts"]
      .sub("{mandateId}", mandate_id)
      .sub("{accountId}", "")
      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.delete(mandate_id:, id:, access_token:)
      uri = Ponto.api_schema["givenMandate"]["accounts"]
      .sub("{mandateId}", mandate_id)
      .sub("{accountId}", id)
      destroy_by_uri(uri: uri, access_token: access_token)
    end
  end
end