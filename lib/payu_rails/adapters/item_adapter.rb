module PayuRails
  module Adapters
    class ItemAdapter < BaseAdapter
      attr_accessor :product

      OPTIONAL = []

      def initialize(obj)
        @item = obj
        @product = ProductAdapter.new(obj)
        self
      end

      # REQUIRED
      # Quantity of the product
      # Return: INTEGER
      def quantity
        not_yet
      end
    end
  end
end
