module PayuRails
  module Adapters
    class ShippingCostAdapter
      attr_accessor :unit_price

      OPTIONAL = [:shipping_cost]

      def initialize(obj)
        @shipping_cost = obj
        @unit_price = UnitPriceAdapter.new(obj)
        self
      end

      # REQUIRED
      def shipping_cost_url
        PayuRails.shipping_cost_url
      end
    end
  end
end
