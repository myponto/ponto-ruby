module Ponto
  class BulkPayment < Ponto::BaseResource
    def self.create(account_id:, access_token: nil, **attributes)
      path = Ponto.api_schema["account"]["bulkPayments"]
        .gsub("{accountId}", account_id)
        .gsub("{bulkPaymentId}", "")
      uri = Ponto.client.build_uri(path)
      create_by_uri(
        uri: uri,
        resource_type: "bulkPayment",
        attributes: attributes,
        access_token: access_token
      )
    end

    def self.find(id:, account_id:, access_token:)
      uri = Ponto.api_schema["account"]["bulkPayments"]
        .gsub("{accountId}", account_id)
        .sub("{bulkPaymentId}", id)
      find_by_uri(uri: uri, access_token: access_token)
    end

    def self.delete(id:, account_id:, access_token:)
      uri = Ponto.api_schema["account"]["bulkPayments"]
        .gsub("{accountId}", account_id)
        .sub("{bulkPaymentId}", id)
      destroy_by_uri(uri: uri, access_token: access_token)
    end
  end
end
