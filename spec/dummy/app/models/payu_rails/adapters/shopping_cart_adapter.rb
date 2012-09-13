module PayuRails
  module Adapters
    class ShoppingCartAdapter < BaseAdapter
      attr_accessor :items

      OPTIONAL = [:discount_total]

      def initialize(obj)
        @items = []
        @items << ItemAdapter.new(obj)
        self
      end

      # REQUIRED
      # Total price of the items in the shopping cart, excluding shipping costs and discounts.
      def grand_total
        10000
      end

      # REQUIRED
      # One of the UnitPrice::CURRENCY_CODES
      def currency_code
        "PLN"
      end

      # # OPTIONAL
      # # Total discount for the shopping cart items
      # def discount_total
      #   not_yet
      # end
    end
  end
end
