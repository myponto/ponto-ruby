module Ponto
  class OrganizationAccount < Ponto::BaseResource
    def self.list(access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["organizationAccounts"]
      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end
  end
end