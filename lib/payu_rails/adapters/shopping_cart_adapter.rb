module PayuRails
  module Adapters
    class ShoppingCartAdapter < BaseAdapter

      OPTIONAL = [:discount_total]

      def initialize(obj)
        @items = []
        obj.items.each {|e| @items << ItemAdapter.new(e)}
      end

      # REQUIRED
      def grand_total
        not_yet
      end

      # REQUIRED
      def currency_code
        # One of the UnitPrice::CURRENCY_CODES
        not_yet
      end

      # # OPTIONAL
      # def discount_total
      #   not_yet
      # end
    end
  end
end
