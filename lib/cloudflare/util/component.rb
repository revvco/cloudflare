#
# component.rb
# Cloudflare
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

require 'ostruct'

module Cloudflare
  module Util
    class Component
      # Get the nested value as a hash
      # @param [Object] an object to change into a hash
      # @return [Hash] hash of the val
      def self.parse(input)
        if input.is_a? Array
          array_of_ostructs = []
          input.each do |i|
            array_of_ostructs << Component.parse(i)
          end
          return array_of_ostructs
        else
          return Component.to_ostruct(input)
        end
      end

      def self.to_ostruct(input)
        o = OpenStruct.new(input)
        input.each do |k,v|
          o.send(:"#{k}=", Component.parse(v)) if v.is_a?(Hash) || v.is_a?(Array)
        end
        o
      end

      def self.parse_response(response)
        parsed = JSON.parse(response.body)
        self.parse(parsed)
      end
    end
  end
end