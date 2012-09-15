module PayuRails
  module Adapters
    class OrderAdapter < BaseAdapter
      attr_accessor :shopping_cart

      OPTIONAL = [:validity_time, :order_url, :e_invoice_provided]
      ORDER_TYPES = ["VIRTUAL", "MATERIAL", "SURCHARGE"]

      def initialize(order)
        @order = order
        @shopping_cart = ShoppingCartAdapter.new(order)
        self
      end

      # REQUIRED
      # Return: INTEGER
      def id
        # @order.id
        not_yet
      end

      # REQUIRED
      # Return: One of OrderAdapter::ORDER_TYPES
      def order_type
        not_yet
      end

      # REQUIRED
      # Generation date of payment request - according to ISO standard
      # Return: DateTime ex. Date.today.iso8601
      def order_created_date
        not_yet
      end

      # REQUIRED
      # Description of the order defined by a merchant
      # Return: STRING
      def order_description
        not_yet
      end
      
      # # OPTIONAL
      # # Validity time of the order (in minutes) counted from the moment of OrderCreateDate. 
      # # Missing value means 1440-minutes timer that the order must be paid without an interruption of the payment flow
      # Return: MINUTS as INTEGER
      # def validity_time
      #   not_yet
      # end

      # # OPTIONAL
      # # URL of the order placed in an e-shop.
      # def order_url
      #   not_yet
      # end

      # # OPTIONAL
      # # Parameter that states whether bayuer can obtain an e-invoice for the order. 
      # # Return: FALSE - merchant does not issue e-invoices. TRUE - merchant issues e-invoices
      # def e_invoice_provided
      #   not_yet
      # end
    end
  end
end
