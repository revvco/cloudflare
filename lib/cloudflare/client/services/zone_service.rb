#
# attribute_service.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Cloudflare
  module Client
    module Services
      class ZoneService < BaseService
        class << self
          def zone_list(params = nil)
            url = Util::Config.get('client.base_url') + Util::Config.get('client.zones') 
            url = build_url(url, params)

            get_act(url, params)
          end

          def zone_ssl_verification(zone_id)
            raise Exceptions::ServiceException, "Zone ID is required." if zone_id.nil?

            url = Util::Config.get('client.base_url') + sprintf(Util::Config.get('client.zones_ssl_verification'), zone_id)

            get_act(url)
          end

          def zone_ssl_settings(zone_id, value)
            raise Exceptions::ServiceException, "Zone ID is required." if zone_id.nil?
            raise Exceptions::ServiceException, "Value is required (off, flexible, full, full_strict)." if value.nil? || !(%w(off flexible full full_strict).include?(value.downcase))
            params = { 
              value: value.downcase
            }

            url = Util::Config.get('client.base_url') + sprintf(Util::Config.get('client.zones_ssl_settings'), zone_id)

            patch_act(url, params.to_json)
          end

          def get_dns_record(zone_id, dns_record_id)
            raise Exceptions::ServiceException, "Zone ID is required." if zone_id.nil?
            raise Exceptions::ServiceException, "DNS Record ID is required." if dns_record_id.nil?

            url = Util::Config.get('client.base_url') + sprintf(Util::Config.get('client.zones_dns_records_crud'), zone_id, dns_record_id)

            get_act(url)
          end

          def create_dns_record(zone_id, type, name, content, ttl=120, proxied=true)
            raise Exceptions::ServiceException, "Zone ID is required." if zone_id.nil?
            raise Exceptions::ServiceException, "Type is required (A, AAAA, CNAME, TXT, SRV, LOC, MX, NS, SPF)." if type.nil? || !(%w(A AAAA CNAME TXT SRV LOC MX NS SPF).include?(type.upcase))
            raise Exceptions::ServiceException, "Name is required." if name.nil?
            raise Exceptions::ServiceException, "Content is required." if content.nil?

            params = {
              type: type,
              name: name,
              content: content,
              ttl: ttl,
              proxied: proxied
            }

            url = Util::Config.get('client.base_url') + sprintf(Util::Config.get('client.zones_dns_records'), zone_id)

            post_act(url, params.to_json)
          end

          def update_dns_record(zone_id, dns_record_id, type, name, content, ttl=120, proxied=true)
            raise Exceptions::ServiceException, "Zone ID is required." if zone_id.nil?
            raise Exceptions::ServiceException, "DNS Record ID is required." if dns_record_id.nil?
            raise Exceptions::ServiceException, "Type is required (A, AAAA, CNAME, TXT, SRV, LOC, MX, NS, SPF)." if type.nil? || !(%w(A AAAA CNAME TXT SRV LOC MX NS SPF).include?(type.upcase))
            raise Exceptions::ServiceException, "Name is required." if name.nil?
            raise Exceptions::ServiceException, "Content is required." if content.nil?

            params = {
              type: type,
              name: name,
              content: content,
              ttl: ttl,
              proxied: proxied
            }

            url = Util::Config.get('client.base_url') + sprintf(Util::Config.get('client.zones_dns_records_crud'), zone_id, dns_record_id)

            put_act(url, params.to_json)
          end

          def destroy_dns_record(zone_id, dns_record_id)
            raise Exceptions::ServiceException, "Zone ID is required." if zone_id.nil?
            raise Exceptions::ServiceException, "DNS Record ID is required." if dns_record_id.nil?

            url = Util::Config.get('client.base_url') + sprintf(Util::Config.get('client.zones_dns_records_crud'), zone_id, dns_record_id)

            delete_act(url)
          end
        end
      end
    end
  end
end