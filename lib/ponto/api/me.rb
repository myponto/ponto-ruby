module Ponto
  class Me < Ponto::BaseResource
    def self.get(access_token: nil, headers: nil)
      uri = Ponto.api_schema["me"]
      result = find_by_uri(uri: uri, headers: headers, access_token: access_token)
    end
  end
end
