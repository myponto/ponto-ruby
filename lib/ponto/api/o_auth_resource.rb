module Ponto
  class OAuthResource < OpenStruct
    def self.create_by_uri(uri:, payload:, headers: nil)
      raw_item = Ponto.client.post(uri: uri, payload: payload, headers: headers)
      raw_item = {} if raw_item == ""
      new(raw_item)
    end

    def initialize(raw)
      super(raw)
    end
  end
end
