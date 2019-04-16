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
        if auth_email.nil?
          raise ArgumentError.new(Util::Config.get('errors.auth_email_missing'))
        end
        if auth_key.nil?
          raise ArgumentError.new(Util::Config.get('errors.auth_key_missing'))
        end
        @zone_service = Client::Services::ZoneService.new(auth_email, auth_key)
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

      def destroy_dns_record(zone_id, dns_record_id)
        zone_service.destroy_dns_record(zone_id, dns_record_id)
      end

      def zone_custom_hostname_list(params=nil)
        zone_service.zone_custom_hostname_list(params)
      end
      
      def zone_create_custom_hostname(zone_id, hostname)
        zone_service.zone_create_custom_hostname(zone_id, hostname)
      end
      
      def zone_custom_hostname(zone_id, custom_hostname_id)
        zone_service.zone_custom_hostname(zone_id, custom_hostname_id)
      end
      
      def zone_delete_custom_hostname(zone_id, custom_hostname_id)
        zone_service.zone_delete_custom_hostname(zone_id, custom_hostname_id)
      end
    end
  end
end
