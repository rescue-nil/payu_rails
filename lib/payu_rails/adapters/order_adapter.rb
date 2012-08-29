module PayuRails
  module Adapters
    class OrderAdapter < BaseAdapter
      attr_accessor :shopping_card

      OPTIONAL = [:validity_time, :order_url, :e_invoice_provided]

      def initialize(order)
        @order = order
        @shopping_card = ShoppingCartAdapter.new(order)
      end

      # REQUIRED
      def merchant_pos_id
        not_yet
      end

      # REQUIRED
      def session_id
        not_yet
      end

      # REQUIRED
      def order_type
        not_yet
      end

      # REQUIRED
      def merchant_authorization_key
        not_yet
      end

      # REQUIRED
      def order_created_date
        not_yet
      end

      # REQUIRED
      def order_description
        not_yet
      end
      
      # # OPTIONAL
      # def validity_time
      #   not_yet
      # end

      # # OPTIONAL
      # def order_url
      #   not_yet
      # end

      # # OPTIONAL
      # def e_invoice_provided
      #   not_yet
      # end
    end
  end
end
