module Ponto
  class GivenMandate < Ponto::BaseResource
    def self.list(access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["givenMandates"].sub("{mandateId}", "")

      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.find(id:, access_token:)
      uri = Ponto.api_schema["givenMandates"].sub("{mandateId}", id)
      find_by_uri(uri: uri, access_token: access_token)
    end

    def self.delete(id:, access_token:)
      uri = Ponto.api_schema["givenMandates"].gsub("{mandateId}", id)
      destroy_by_uri(uri: uri, access_token: access_token)
    end
  end
end