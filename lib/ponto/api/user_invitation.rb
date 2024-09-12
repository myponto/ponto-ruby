module Ponto
  class UserInvitation < Ponto::BaseResource
    def self.list(access_token: nil, headers: nil, **query_params)
      uri = Ponto.api_schema["userInvitations"].sub("{invitationId}", "")

      list_by_uri(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
    end

    def self.create(access_token: nil, **attributes)
      path = Ponto.api_schema["userInvitations"].sub("{invitationId}", "")
      uri = Ponto.client.build_uri(path)
      create_by_uri(
        uri: uri,
        resource_type: "userInvitation",
        attributes: attributes,
        access_token: access_token
      )
    end

    def self.delete(id:, access_token:)
      uri = Ponto.api_schema["userInvitations"].gsub("{invitationId}", id)
      destroy_by_uri(uri: uri, access_token: access_token)
    end
  end
end