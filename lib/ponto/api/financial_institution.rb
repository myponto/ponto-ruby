module Ponto
  class FinancialInstitution < Ponto::BaseResource
    def self.list(access_token: nil, **query_params)
      uri = Ponto.api_schema["financialInstitutions"].sub("{financialInstitutionId}", "")
      list_by_uri(uri: uri, query_params: query_params, access_token: access_token)
    end

    def self.find(id:, access_token: nil)
      uri = Ponto.api_schema["financialInstitutions"].sub("{financialInstitutionId}", id)
      find_by_uri(uri: uri, access_token: access_token)
    end
  end
end
