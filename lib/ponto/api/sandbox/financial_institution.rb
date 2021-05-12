module Ponto
  module Sandbox
    class FinancialInstitution < Ponto::BaseResource
      def self.list(access_token:, **query_params)
        uri = Ponto.api_schema["sandbox"]["financialInstitutions"].sub("{financialInstitutionId}", "")
        list_by_uri(uri: uri, query_params: query_params, access_token: access_token)
      end

      def self.find(id:, access_token:)
        uri = Ponto.api_schema["sandbox"]["financialInstitutions"].sub("{financialInstitutionId}", id)
        find_by_uri(uri: uri, access_token: access_token)
      end
    end
  end
end
