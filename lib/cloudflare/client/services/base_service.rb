#
# base_service.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Cloudflare
  module Client
    module Services
      class BaseService
        attr_accessor :auth_email, :auth_key

        def initialize(auth_email, auth_key)
          @auth_email = auth_email
          @auth_key = auth_key
        end

        protected

        # Return required headers for making an http request with Cloudflare
        # @param [String] content_type - The MIME type of the body of the request, default is 'application/json'
        # @return [Hash] - authorization headers
        def post_act(url, body)
          Cloudflare::Util::Component.parse_response(HTTParty.post(url, body: body, headers: get_headers))
        end

        def get_act(url, body=nil)
          Cloudflare::Util::Component.parse_response(HTTParty.get(url, body: body, headers: get_headers))
        end

        def patch_act(url, body)
          Cloudflare::Util::Component.parse_response(HTTParty.patch(url, body: body, headers: get_headers))
        end

        def put_act(url, body)
          Cloudflare::Util::Component.parse_response(HTTParty.put(url, body: body, headers: get_headers))
        end

        def delete_act(url, body)
         Cloudflare::Util::Component.parse_response(HTTParty.delete(url, body: body, headers: get_headers))
        end

        # Return required headers for making an http request with Cloudflare
        # @param [String] content_type - The MIME type of the body of the request, default is 'application/json'
        # @return [Hash] - authorization headers
        def get_headers(content_type = 'application/json')
          {
            'Content-Type'  => content_type,
            "X-Auth-Email"  => auth_email,
            "X-Auth-Key"    => auth_key
          }
        end

        # Build a url from the base url and query parameters hash. Query parameters
        # should not be URL encoded because this method will handle that
        # @param [String] url - The base url
        # @param [Hash] params - A hash with query parameters
        # @return [String] - the url with query parameters hash 
        def build_url(url, params = nil)
          url += '?' + Util::Helpers.http_build_query(params) unless params.nil?

          url
        end
      end
    end
  end
end
