module Ponto
  class IntegrationAccount < Ponto::BaseResource
    def self.list(integration_id:, access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["integration"]["accounts"]
      .sub("{integrationId}", integration_id)
      .sub("{accountId}", "")

      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.create(integration_id:, access_token: nil, **attributes)
      path = Ponto.api_schema["integration"]["accounts"]
      .sub("{integrationId}", integration_id)
      .sub("{accountId}", "")

      uri = Ponto.client.build_uri(path)
      create_by_uri(
        uri: uri,
        resource_type: "integrationAccount",
        attributes: attributes,
        access_token: access_token
      )
    end

    def self.delete(integration_id:, id:, access_token:)
      uri = Ponto.api_schema["integration"]["accounts"]
      .gsub("{integrationId}", integration_id)
      .gsub("{accountId}", id)

      destroy_by_uri(uri: uri, access_token: access_token)
    end
  end
end