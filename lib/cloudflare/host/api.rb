#
# api.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

require 'httparty'

module Cloudflare
  module Host
    class Api
      # Class constructor
      # @param [String] host_key - Cloudflare Host Key
      # @param [String] user_key - Cloudflare User Key
      # @return
      def initialize(host_key = nil, user_key = nil)
        Host::Services::BaseService.host_key = host_key || Util::Config.get('auth.host_key')
        Host::Services::BaseService.user_key = user_key
        if Host::Services::BaseService.host_key.nil? || Host::Services::BaseService.host_key == ''
          raise ArgumentError.new(Util::Config.get('errors.host_key_missing'))
        end
        if Host::Services::BaseService.user_key.nil? || Host::Services::BaseService.user_key == ''
          raise ArgumentError.new(Util::Config.get('errors.user_key_missing'))
        end
      end

      # Zone Service Methods
      def zone_lookup(zone_name)
        Host::Services::ZoneService.zone_lookup(zone_name)
      end

      def zone_set(zone_name, resolve_to, subdomains)
        Host::Services::ZoneService.zone_set(zone_name, resolve_to, subdomains)
      end
    end
  end
end