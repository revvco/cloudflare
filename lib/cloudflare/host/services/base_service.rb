#
# base_service.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

module Cloudflare
  module Host
    module Services
      class BaseService
        attr_accessor :host_key, :user_key

        def initialize(host_key, user_key)
          @host_key = host_key
          @user_key = user_key
        end

        protected

        def get_body(act, params)
          {
            act: act,
            host_key: host_key,
            user_key: user_key
          }.merge(params) # add params
        end

        # Return required headers for making an http request with Cloudflare
        # @param [String] content_type - The MIME type of the body of the request, default is 'application/json'
        # @return [Hash] - authorization headers
        def post_act(act, params)
          Cloudflare::Util::Component.parse_response(HTTParty.post(Cloudflare::Util::Config.get('host.base_url'), body: get_body(act, params)))
        end
      end
    end
  end
end