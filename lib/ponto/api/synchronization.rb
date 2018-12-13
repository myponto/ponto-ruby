module Ponto
  class Synchronization < Ponto::BaseResource
    def self.create(**attributes)
      uri = Ponto.api_schema["synchronizations"].sub("{synchronizationId}", "")
      create_by_uri(uri: uri, resource_type: "synchronization", attributes: attributes)
    end

    def self.find(id:)
      uri = Ponto.api_schema["synchronizations"].sub("{synchronizationId}", id)
      find_by_uri(uri: uri)
    end
  end
end
