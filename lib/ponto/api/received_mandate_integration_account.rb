module Ponto
  class ReceivedMandateIntegrationAccount < Ponto::BaseResource
    def self.list(mandate_id:, integration_id:, access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["receivedMandate"]["integration"]["accounts"]
      .sub("{mandateId}", mandate_id)
      .sub("{integrationId}", integration_id)
      .sub("{accountId}", "")

      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.create(mandate_id:, integration_id:, access_token: nil, **attributes)
      uri = Ponto.api_schema["receivedMandate"]["integration"]["accounts"]
      .sub("{mandateId}", mandate_id)
      .sub("{integrationId}", integration_id)
      .sub("{accountId}", "")

      create_by_uri(
        uri: uri,
        resource_type: "receivedMandateIntegrationAccount",
        attributes: attributes,
        access_token: access_token
      )
    end

    def self.delete(mandate_id:, integration_id:, id:, access_token:)
      uri = Ponto.api_schema["receivedMandate"]["integration"]["accounts"]
      .sub("{mandateId}", mandate_id)
      .sub("{integrationId}", integration_id)
      .sub("{accountId}", id)
      destroy_by_uri(uri: uri, access_token: access_token)
    end
  end
end