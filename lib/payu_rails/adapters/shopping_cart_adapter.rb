module PayuRails
  module Adapters
    class ShoppingCartAdapter < BaseAdapter
      attr_accessor :items

      OPTIONAL = [:discount_total]

      def initialize(obj)
        @items = []
        obj.items.each {|e| @items << ItemAdapter.new(e)}
        self
      end

      # REQUIRED
      # Total price of the items in the shopping cart, excluding shipping costs and discounts.
      # Return: INTEGER CENTS
      def grand_total
        not_yet
      end

      # REQUIRED
      # One of the UnitPrice::CURRENCY_CODES
      # Return: STRING
      def currency_code
        not_yet
      end

      # # OPTIONAL
      # # Total discount for the shopping cart items
      # # Return: INTEGER CENTS
      # def discount_total
      #   not_yet
      # end
    end
  end
end
