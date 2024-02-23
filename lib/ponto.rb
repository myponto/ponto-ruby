require "ostruct"
require "openssl"
require "uri"
require "rest_client"
require "json"
require "securerandom"
require "base64"

require_relative "ponto/util"
require_relative "ponto/error"
require_relative "ponto/collection"
require_relative "ponto/client"
require_relative "ponto/api/base_resource"
require_relative "ponto/api/o_auth_resource"
require_relative "ponto/api/account"
require_relative "ponto/api/pending_transaction"
require_relative "ponto/api/transaction"
require_relative "ponto/api/financial_institution"
require_relative "ponto/api/payment"
require_relative "ponto/api/bulk_payment"
require_relative "ponto/api/payment_request"
require_relative "ponto/api/synchronization"
require_relative "ponto/api/access_token"
require_relative "ponto/api/sandbox/financial_institution"
require_relative "ponto/api/sandbox/financial_institution_account"
require_relative "ponto/api/sandbox/financial_institution_transaction"

module Ponto
  class << self
    def client
      options = configuration.to_h.delete_if { |_, v| v.nil? }
      @client ||= Ponto::Client.new(**options)
    end

    def configure
      @client        = nil
      @api_schema    = nil
      @configuration = nil
      yield configuration
    end

    def configuration
      @configuration ||= Struct.new(
        :client_id,
        :client_secret,
        :token,
        :api_scheme,
        :api_host,
        :api_port,
        :ssl_ca_file
      ).new
    end

    def api_schema
      @api_schema ||= client.get(uri: client.base_uri)["links"]
    end

    def respond_to_missing?(method_name, include_private = false)
      client.respond_to?(method_name, include_private)
    end

    def method_missing(method_name, *args, &block)
      if client.respond_to?(method_name)
        client.__send__(method_name, *args, &block)
      else
        super
      end
    end
  end
end
