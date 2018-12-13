module Ponto
  class BaseResource < OpenStruct
    def self.create_by_uri(uri:, resource_type:, attributes:, meta: nil)
      payload = {
        data: {
          type:       resource_type,
          attributes: attributes
        }
      }
      payload[:data][:meta] = meta if meta
      raw_item = Ponto.client.post(uri: uri, payload: payload)
      new(raw_item["data"])
    end

    def self.list_by_uri(uri:, query_params: {}, headers: nil)
      raw_response = Ponto.client.get(uri: uri, query_params: query_params, headers: headers)
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

    def self.find_by_uri(uri:, headers: nil)
      new(find_raw_by_uri(uri: uri, headers: headers))
    end

    def self.find_raw_by_uri(uri:, headers: nil)
      raw_item = Ponto.client.get(uri: uri, headers: headers)
      raw_item["data"]
    end

    def initialize(raw)
      attributes = prepare_attributes(raw)
      super(attributes)

      relationships = raw["relationships"] || {}
      setup_relationships(relationships)

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

    def setup_relationships(relationships)
      relationships.each do |key, relationship|
        if relationship["data"]
          klass = Ponto.const_get(Ponto::Util.camelize(key))
          method_name = Ponto::Util.underscore(key)
          define_singleton_method(method_name) do |headers: nil|
            klass.find_by_uri(uri: relationship["links"]["related"], headers: headers)
          end
          self[Ponto::Util.underscore("#{key}_id")] = relationship["data"]["id"]
        else
          singular_key = key[0..-2]
          klass        = Ponto.const_get(Ponto::Util.camelize(singular_key))
          method_name  = Ponto::Util.underscore(key)
          define_singleton_method(method_name) do |headers: nil, **query_params|
            uri = relationship["links"]["related"]
            klass.list_by_uri(uri: uri, headers: headers, query_params: query_params)
          end
        end
      end
    end

    def setup_links(links)
      links.each do |key, link|
        self[Ponto::Util.underscore("#{key}_link")] = link
      end
    end
  end
end
