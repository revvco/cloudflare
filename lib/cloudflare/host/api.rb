#
# api.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

require 'httparty'

module Cloudflare
  module Host
    class Api
      attr_accessor :zone_service

      # Class constructor
      # @param [String] host_key - Cloudflare Host Key
      # @param [String] user_key - Cloudflare User Key
      # @return
      def initialize(host_key = nil, user_key = nil)
        if host_key.nil?
          raise ArgumentError.new(Util::Config.get('errors.host_key_missing'))
        end
        if user_key.nil?
          raise ArgumentError.new(Util::Config.get('errors.user_key_missing'))
        end
        @zone_service = Host::Services::ZoneService.new(host_key, user_key)
      end

      # Zone Service Methods
      def zone_lookup(zone_name)
        zone_service.zone_lookup(zone_name)
      end

      def zone_set(zone_name, resolve_to, subdomains)
        zone_service.zone_set(zone_name, resolve_to, subdomains)
      end
    end
  end
end