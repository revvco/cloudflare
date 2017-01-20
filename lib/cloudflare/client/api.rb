#
# api.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

require 'httparty'

module Cloudflare
  module Client
    class Api
      attr_accessor :zone_service

      # Class constructor
      # @param [String] auth_email - Cloudflare Client Auth Email
      # @param [String] auth_key - Cloudflare Client Auth key
      # @return
      def initialize(auth_email = nil, auth_key = nil)
        if Client::Services::BaseService.auth_email.nil? || Client::Services::BaseService.auth_email == ''
          raise ArgumentError.new(Util::Config.get('errors.auth_email_missing'))
        end
        if Client::Services::BaseService.auth_key.nil? || Client::Services::BaseService.auth_key == ''
          raise ArgumentError.new(Util::Config.get('errors.auth_key_missing'))
        end
        @zone_service = Host::Services::ZoneService.new(host_key, user_key)
      end

      # Zone Service Methods
      def zone_list(params=nil)
        zone_service.zone_list(params)
      end

      def zone_ssl_verification(zone_id)
        zone_service.zone_ssl_verification(zone_id)
      end

      def zone_ssl_settings(zone_id, value)
        zone_service.zone_ssl_settings(zone_id, value)
      end

      def get_dns_record(zone_id, dns_record_id)
        zone_service.get_dns_record(zone_id, dns_record_id)
      end

      def create_dns_record(zone_id, type, name, content, ttl=120, proxied=true)
        zone_service.create_dns_record(zone_id, type, name, content, ttl, proxied)
      end

      def update_dns_record(zone_id, dns_record_id, type, name, content, ttl=120, proxied=true)
        zone_service.update_dns_record(zone_id, dns_record_id, type, name, content, ttl, proxied)
      end
    end
  end
end