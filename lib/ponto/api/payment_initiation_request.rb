module Ponto
  class PaymentInitiationRequest < Ponto::BaseResource
    def self.create(account_id:, access_token: nil, **attributes)
      path = Ponto.api_schema["account"]["paymentInitiationRequests"]
        .gsub("{accountId}", account_id)
        .sub("{paymentInitiationRequestId}", "")
      uri = Ponto.client.build_uri(path)
      create_by_uri(
        uri: uri,
        resource_type: "paymentInitiationRequest",
        attributes: attributes,
        access_token: access_token
      )
    end

    def self.find(id:, account_id:, access_token:)
      uri = Ponto.api_schema["account"]["paymentInitiationRequests"]
        .gsub("{accountId}", account_id)
        .sub("{paymentInitiationRequestId}", id)
      find_by_uri(uri: uri, access_token: access_token)
    end
  end
end
