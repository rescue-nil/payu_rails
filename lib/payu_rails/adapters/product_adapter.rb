module PayuRails
  module Adapters
    class ProductAdapter < BaseAdapter
      attr_accessor :unit_price

      OPTIONAL = [:weight, :size, :discount, :extra_info, :code, :version, :properties]

      def initialize(obj)
        @product = obj
        @unit_price = UnitPriceAdapter.new(obj)
      end

      # REQUIRED
      def name
        not_yet
      end

      # # OPTIONAL
      # # TODO: Additional nesting in xml
      # def weight
      #   not_yet
      # end

      # # OPTIONAL
      # # TODO: Additional nesting in xml
      # def size
      #   not_yet
      # end

      # # TODO: Additional nesting in xml
      # def properties
      #   not_yet
      # end

      # # OPTIONAL
      # def discount
      #   not_yet
      # end

      # # OPTIONAL
      # def extra_info
      #   not_yet
      # end

      # # OPTIONAL
      # def code
      #   not_yet
      # end

      # # OPTIONAL
      # def version
      #   not_yet
      # end
    end
  end
end
