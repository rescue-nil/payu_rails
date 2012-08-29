module PayuRails
  module Adapters
    class ShoppingCartAdapter < BaseAdapter

      OPTIONAL = [:discount_total]

      def initialize(obj)
        @items = []
        obj.items.each {|e| @items << ItemAdapter.new(e)}
      end

      # REQUIRED
      # Total price of the items in the shopping cart, excluding shipping costs and discounts.
      def grand_total
        not_yet
      end

      # REQUIRED
      # One of the UnitPrice::CURRENCY_CODES
      def currency_code
        not_yet
      end

      # # OPTIONAL
      # # Total discount for the shopping cart items
      # def discount_total
      #   not_yet
      # end
    end
  end
end
