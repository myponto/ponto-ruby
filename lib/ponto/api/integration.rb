module Ponto
  class Integration  < Ponto::BaseResource
    def self.list(access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["integrations"].sub("{integrationId}", "")
      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.create(access_token: nil, **attributes)
      path = Ponto.api_schema["integrations"].sub("{integrationId}", "")
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