module Ponto
  module Sandbox
    class FinancialInstitutionTransaction < Ponto::BaseResource
      def self.list(access_token:, financial_institution_id:, financial_institution_account_id:, **query_params)
        uri = Ponto.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionTransactions"]
          .sub("{financialInstitutionId}", financial_institution_id)
          .sub("{financialInstitutionAccountId}", financial_institution_account_id)
          .sub("{financialInstitutionTransactionId}", "")
        list_by_uri(uri: uri, query_params: query_params, access_token: access_token)
      end

      def self.find(access_token:, id:, financial_institution_id:, financial_institution_account_id:)
        uri = Ponto.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionTransactions"]
          .sub("{financialInstitutionId}", financial_institution_id)
          .sub("{financialInstitutionAccountId}", financial_institution_account_id)
          .sub("{financialInstitutionTransactionId}", id)
        find_by_uri(uri: uri, access_token: access_token)
      end

      def self.create(access_token:, financial_institution_id:, financial_institution_account_id:, **attributes)
        uri = Ponto.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionTransactions"]
          .sub("{financialInstitutionId}", financial_institution_id)
          .sub("{financialInstitutionAccountId}", financial_institution_account_id)
          .sub("{financialInstitutionTransactionId}", "")
        create_by_uri(uri: uri, resource_type: "financialInstitutionTransaction", attributes: attributes, access_token: access_token)
      end

      def self.update(access_token:, id:, financial_institution_id:, financial_institution_account_id:, **attributes)
        uri = Ponto.api_schema["sandbox"]["financialInstitution"]["financialInstitutionAccount"]["financialInstitutionTransactions"]
          .sub("{financialInstitutionId}", financial_institution_id)
          .sub("{financialInstitutionAccountId}", financial_institution_account_id)
          .sub("{financialInstitutionTransactionId}", id)
        update_by_uri(uri: uri, resource_type: "financialInstitutionTransaction", attributes: attributes, access_token: access_token)
      end
    end
  end
end
