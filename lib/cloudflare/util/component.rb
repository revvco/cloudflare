#
# component.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

require 'ostruct'

module Cloudflare
  module Util
    class Component
      def self.parse_response(response)
        JSON.parse(response.body, object_class: OpenStruct)
      end
    end
  end
end