module Ponto
  class Synchronization < Ponto::BaseResource
    def self.create(access_token: nil, **attributes)
      uri = Ponto.api_schema["synchronizations"].sub("{synchronizationId}", "")
      create_by_uri(uri: uri, resource_type: "synchronization", attributes: attributes, access_token: access_token)
    end

    def self.find(id:, access_token: nil)
      uri = Ponto.api_schema["synchronizations"].sub("{synchronizationId}", id)
      find_by_uri(uri: uri, access_token: access_token)
    end
  end
end
