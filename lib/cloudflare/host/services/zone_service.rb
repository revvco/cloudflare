#
# attribute_service.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Cloudflare
  module Host
    module Services
      class ZoneService < BaseService
        class << self
          def zone_lookup(zone_name)
            raise Exceptions::ServiceException, "Zone Name is required." if zone_name.nil?
            params = {
              zone_name: zone_name
            }
            response = JSON.parse(post_act(:zone_lookup, params).body)["response"]
            Cloudflare::Util::Component.to_ostruct(response)
          end

          def zone_set(zone_name, resolve_to, subdomains)
            raise Exceptions::ServiceException, "Zone Name is required." if zone_name.nil?
            raise Exceptions::ServiceException, "Resolve Host is required." if resolve_to.nil?
            raise Exceptions::ServiceException, "Subdomain is required." if subdomains.nil?

            params = {
              zone_name: zone_name,
              resolve_to: resolve_to,
              subdomains: subdomains
            }
            response = JSON.parse(post_act(:zone_set, params).body)["response"]
            Cloudflare::Util::Component.to_ostruct(response)
          end
        end
      end
    end
  end
end