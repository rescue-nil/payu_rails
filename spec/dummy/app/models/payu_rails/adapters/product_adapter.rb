module PayuRails
  module Adapters
    class ProductAdapter < BaseAdapter
      attr_accessor :unit_price

      OPTIONAL = [:weight, :size, :discount, :extra_info, :code, :version, :properties]

      def initialize(obj)
        @product = obj
        @unit_price = UnitPriceAdapter.new(obj)
        self
      end

      # REQUIRED
      # Name of the product
      def name
        not_yet
      end

      # # OPTIONAL
      # # TODO: Additional nesting in xml
      # # Weight of the product
      # def weight
      #   not_yet
      # end

      # # OPTIONAL
      # # TODO: Additional nesting in xml
      # # Size of the product
      # def size
      #   not_yet
      # end

      # # TODO: Additional nesting in xml
      # # Flexible set of attributes that extend the typical 
      # # business entity used by all other messages
      # def properties
      #   not_yet
      # end

      # # OPTIONAL
      # # Discount amount for a given product
      # def discount
      #   not_yet
      # end

      # # OPTIONAL
      # # Additional information about a product
      # def extra_info
      #   not_yet
      # end

      # # OPTIONAL
      # # Unique product code in a merchant's system
      # def code
      #   not_yet
      # end

      # # OPTIONAL
      # # Product version
      # def version
      #   not_yet
      # end
    end
  end
end
