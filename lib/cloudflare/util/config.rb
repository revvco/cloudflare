#
# config.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Cloudflare
  module Util
    class Config

      # Return a hash of configuration strings
      # @return [Hash] - hash of configuration properties
      @props = {
        # Host Endpoints
        :host => {
          :base_url                       => 'https://api.cloudflare.com/host-gw.html'
        },

        # Client Endpoints
        :client => {
          :base_url                       => 'https://api.cloudflare.com/client/v4/',
          
          :zones                          => 'zones',
          :zones_ssl_verification         => 'zones/%s/ssl/verification',
          :zones_ssl_settings             => 'zones/%s/settings/ssl',
          :zones_dns_records              => 'zones/%s/dns_records',
          :zones_dns_records_crud         => 'zones/%s/dns_records/%s',

          :zones_custom_hostnames         => 'zones/%s/custom_hostnames',
          :zones_custom_hostname          => 'zones/%s/custom_hostnames/%s',
        },

        # Errors to be returned for various exceptions
        :errors => {
          :api_key_missing      => 'api_key required either explicitly or in configuration.',
          :access_token_missing => 'access_token required explicitly.',
          :api_secret_missing   => 'The api_secret is missing in explicit call or configuration.'
        }
      }

      class << self
        attr_accessor :props

         def configure 
          yield props if block_given?
        end

        # Get a configuration property given a specified location, example usage: Config::get('auth.token_endpoint')
        # @param [String] index - location of the property to obtain
        # @return [String]
        def get(index)
          properties = index.split('.')
          get_value(properties, props)
        end

        private

        # Navigate through a config array looking for a particular index
        # @param [Array] index The index sequence we are navigating down
        # @param [Hash, String] value The portion of the config array to process
        # @return [String]
        def get_value(index, value)
          index = index.is_a?(Array) ? index : [index]
          key = index.shift.to_sym
          value.is_a?(Hash) and value[key] and value[key].is_a?(Hash) ?
          get_value(index, value[key]) :
          value[key]
        end
      end

    end
  end
end
