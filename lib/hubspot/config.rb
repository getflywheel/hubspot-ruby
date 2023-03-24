require 'logger'

module Hubspot
  class Config

    CONFIG_KEYS = [:hapikey, :bearer_token, :base_url, :portal_id, :logger]
    DEFAULT_LOGGER = Logger.new('/dev/null')

    class << self
      attr_accessor *CONFIG_KEYS

      def configure(config)
        config.stringify_keys!
        @hapikey = config["hapikey"]
        @bearer_token = config["bearer_token"]
        @base_url = config["base_url"] || "https://api.hubapi.com"
        @portal_id = config["portal_id"]
        @logger = config['logger'] || DEFAULT_LOGGER
        self
      end

      def reset!
        @hapikey = nil
        @bearer_token = nil
        @base_url = "https://api.hubapi.com"
        @portal_id = nil
        @logger = DEFAULT_LOGGER
      end

      def ensure!(*params)
        params.each do |p|
          raise Hubspot::ConfigurationError.new("'#{p}' not configured") unless instance_variable_get "@#{p}"
        end
      end
    end

    reset!
  end
end
