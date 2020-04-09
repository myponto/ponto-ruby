module Ponto
  module Sandbox
    class FinancialInstitutionAccount < Ponto::BaseResource
      def self.list(financial_institution_id:, access_token:, **query_params)
        uri = Ponto.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccounts"].sub("{financialInstitutionId}", financial_institution_id).sub("{financialInstitutionAccountId}", "")
        list_by_uri(uri: uri, query_params: query_params, access_token: access_token)
      end

      def self.find(id:, financial_institution_id:, access_token:)
        uri = Ponto.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccounts"].sub("{financialInstitutionId}", financial_institution_id).sub("{financialInstitutionAccountId}", id)
        find_by_uri(uri: uri, access_token: access_token)
      end
    end
  end
end
