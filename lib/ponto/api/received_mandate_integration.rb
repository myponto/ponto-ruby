module Ponto
  class ReceivedMandateIntegration < Ponto::BaseResource
    def self.list(mandate_id:, access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["receivedMandate"]["integrations"].sub("{mandateId}", mandate_id)
      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.create(mandate_id:, access_token: nil, **attributes)
      path = Ponto.api_schema["receivedMandate"]["integrations"].sub("{mandateId}", mandate_id)
      uri = Ponto.client.build_uri(path)
      create_by_uri(
        uri: uri,
        resource_type: "integration",
        attributes: attributes,
        access_token: access_token
      )
    end
  end
end