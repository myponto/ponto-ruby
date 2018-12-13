module Ponto
  class PaymentInitiationRequest < Ponto::BaseResource
    def self.create(account_id:, **attributes)
      path = Ponto.api_schema["account"]["paymentInitiationRequests"]
        .gsub("{accountId}", account_id)
        .sub("{paymentInitiationRequestId}", "")
      uri = Ponto.client.build_uri(path)
      create_by_uri(
        uri: uri,
        resource_type: "paymentInitiationRequest",
        attributes: attributes
      )
    end

    def self.find(id:, account_id:)
      uri = Ponto.api_schema["account"]["paymentInitiationRequests"]
        .gsub("{accountId}", account_id)
        .sub("{paymentInitiationRequestId}", id)
      find_by_uri(uri: uri)
    end
  end
end
