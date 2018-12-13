module Ponto
  class FinancialInstitution < Ponto::BaseResource
    def self.list(**query_params)
      uri = Ponto.api_schema["financialInstitutions"].sub("{financialInstitutionId}", "")
      list_by_uri(uri: uri, query_params: query_params)
    end

    def self.find(id:)
      uri = Ponto.api_schema["financialInstitutions"].sub("{financialInstitutionId}", id)
      find_by_uri(uri: uri)
    end
  end
end
