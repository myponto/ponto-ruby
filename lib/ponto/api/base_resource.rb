module Ponto
  class BaseResource < OpenStruct
    def self.create_by_uri(uri:, resource_type:, attributes:, access_token:, meta: nil)
      payload = {
        data: {
          type:       resource_type,
          attributes: attributes
        }
      }
      payload[:data][:meta] = meta if meta
      raw_item = Ponto.client.post(uri: uri, payload: payload, access_token: access_token)
      new(raw_item["data"])
    end

    def self.update_by_uri(uri:, resource_type:, attributes:, access_token:, meta: nil)
      payload = {
        data: {
          type:       resource_type,
          attributes: attributes
        }
      }
      payload[:data][:meta] = meta if meta
      raw_item = Ponto.client.patch(uri: uri, payload: payload, access_token: access_token)
      new(raw_item["data"])
    end

    def self.list_by_uri(uri:, access_token:, query_params: {}, headers: nil)
      raw_response = Ponto.client.get(uri: uri, query_params: query_params, headers: headers, access_token: access_token)
      items        = raw_response["data"].map do |raw_item|
        new(raw_item)
      end
      Ponto::Collection.new(
        klass:                  self,
        items:                  items,
        links:                  raw_response["links"],
        paging:                 raw_response.dig("meta", "paging"),
        synchronized_at:        raw_response.dig("meta", "synchronizedAt"),
        latest_synchronization: raw_response.dig("meta", "latestSynchronization"),
      )
    end

    def self.find_by_uri(uri:, access_token:, headers: nil)
      new(find_raw_by_uri(uri: uri, headers: headers, access_token: access_token), access_token)
    end

    def self.find_raw_by_uri(uri:, access_token:, headers: nil)
      raw_item = Ponto.client.get(uri: uri, headers: headers, access_token: access_token)
      raw_item["data"]
    end

    def self.destroy_by_uri(uri:, access_token:, headers: nil)
      raw_item = Ponto.client.delete(uri: uri, headers: headers, access_token: access_token)
      new(raw_item["data"])
    end

    def initialize(raw, access_token = nil)
      attributes = prepare_attributes(raw)
      super(attributes)

      relationships = raw["relationships"] || {}
      setup_relationships(relationships, access_token)

      links = raw["links"] || {}
      setup_links(links)

      meta = raw["meta"] || {}
    end

    def reload!
      reloaded   = self.class.find_raw_by_uri(uri)
      attributes = prepare_attributes(reloaded)
      attributes.each do |key, value|
        self[key] = value
      end
      self
    end

    private

    def prepare_attributes(raw)
      base = {
        "id"  => raw["id"],
      }
      attributes           = raw["attributes"]    || {}
      meta                 = raw["meta"]          || {}
      params               = base.merge(attributes).merge(meta)
      Ponto::Util.underscorize_hash(params)
    end

    def setup_relationships(relationships, access_token)
      relationships.each do |key, relationship|
        if relationship["data"]
          method_name = Ponto::Util.underscore(key)
          define_singleton_method(method_name) do |headers: nil|
            get_klass(key).find_by_uri(uri: relationship["links"]["related"], headers: headers, access_token: access_token)
          end
          self[Ponto::Util.underscore("#{key}_id")] = relationship["data"]["id"]
        else
          singular_key = key[0..-2]
          method_name  = Ponto::Util.underscore(key)
          define_singleton_method(method_name) do |headers: nil, **query_params|
            uri = relationship["links"]["related"]
            get_klass(singular_key).list_by_uri(uri: uri, headers: headers, query_params: query_params, access_token: access_token)
          end
        end
      end
    end

    def setup_links(links)
      links.each do |key, link|
        self[Ponto::Util.underscore("#{key}_link")] = link
      end
    end

    def get_klass(key)
      key = "transaction" if key == "updatedTransaction"
      Ponto.const_get(Ponto::Util.camelize(key))
    end
  end
end
