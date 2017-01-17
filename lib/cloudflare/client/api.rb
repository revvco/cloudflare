#
# api.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

require 'httparty'

module Cloudflare
  module Client
    class Api
      # Class constructor
      # @param [String] auth_email - Cloudflare Client Auth Email
      # @param [String] auth_key - Cloudflare Client Auth key
      # @return
      def initialize(auth_email = nil, auth_key = nil)
        Client::Services::BaseService.auth_email = auth_email || Util::Config.get('auth.auth_email')
        Client::Services::BaseService.auth_key = auth_key
        if Client::Services::BaseService.auth_email.nil? || Client::Services::BaseService.auth_email == ''
          raise ArgumentError.new(Util::Config.get('errors.auth_email_missing'))
        end
        if Client::Services::BaseService.auth_key.nil? || Client::Services::BaseService.auth_key == ''
          raise ArgumentError.new(Util::Config.get('errors.auth_key_missing'))
        end
      end

      # Zone Service Methods
      def zone_list(params=nil)
        Client::Services::ZoneService.zone_list(params)
      end

      def zone_ssl_verification(zone_id)
        Client::Services::ZoneService.zone_ssl_verification(zone_id)
      end

      def zone_ssl_settings(zone_id, value)
        Client::Services::ZoneService.zone_ssl_settings(zone_id, value)
      end
    end
  end
end