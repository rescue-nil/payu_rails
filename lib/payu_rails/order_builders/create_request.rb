require 'nokogiri'

module PayuRails
  module OrderBuilders
    class CreateRequest < Base
      attr_accessor :result
      # More at: http://www.payu.com/pl/openpayu/OrderDomainRequest.html
      # @options:
      # - *customer_ip - client iess
      def initialize(order, shipping = nil, *args)
        @origin_order  = order
        @options       = args.extract_options!.symbolize_keys! || {}
        @commission    = nil
        @order         = Adapters::OrderAdapter.new(order)
        @shipping_cost = Adapters::ShippingCostAdapter.new(shipping) if shipping.present?
      end

      def build
        @result = Nokogiri::XML::Builder.new :encoding => 'UTF-8' do |xml|
          xml.OpenPayU do
            # Correct namespace url
            xml.doc.root.namespace = xml.doc.root.add_namespace_definition('payu', @@payu_namespace_url)

            # Building header
            build_header(xml)

            # Building content
            xml['payu'].OrderDomainRequest do
              xml['payu'].OrderCreateRequest do
                xml['payu'].ReqId               request_id
                xml['payu'].NotifyUrl           notify_url
                xml['payu'].OrderCancelUrl      order_cancel_url
                xml['payu'].OrderCompleteUrl    order_complete_url
                xml['payu'].CustomerIp          customer_ip

                build_order(xml)
                build_shipping_cost(xml) if @shipping_cost.present?
              end # OrderCreateRequest
            end # OrderDomainRequest
          end # OpenPayU
        end # Nokogiri block

        @result
      end

      private

      def build_order(xml)
        xml['payu'].Order do
          xml['payu'].MerchantPosId             merchant_pos_id
          xml['payu'].SessionId                 session_id #@order.id
          xml['payu'].OrderCreateDate           @order.order_created_date
          xml['payu'].OrderDescription          @order.order_description
          xml['payu'].OrderType                 @order.order_type
          xml['payu'].MerchantAuthorizationKey  merchant_authorization_key

          generate_options(xml, @order)
          build_shopping_cart(xml, @order.shopping_cart)
        end # End Order
      end

      def build_shopping_cart(xml, shopping_cart)
        xml['payu'].ShoppingCart do
          xml['payu'].GrandTotal      shopping_cart.grand_total
          xml['payu'].CurrencyCode    shopping_cart.currency_code

          generate_options(xml, shopping_cart)

          xml['payu'].ShoppingCartItems do
            shopping_cart.items.each do |item|
              build_shopping_cart_item(xml, item)
            end
          end # End ShopingCartItems
        end # End ShoppingCart
      end

      def build_shopping_cart_item(xml, item)
        xml['payu'].ShoppingCartItem do
          xml['payu'].Quantity        item.quantity

          build_product(xml, item.product)
        end
      end

      # Building product section with unit price
      def build_product(xml, product)
        xml['payu'].Product do
          xml['payu'].Name            product.name

          generate_options(xml, product)
          build_unit_price(xml, product.unit_price)
        end
      end

      def build_unit_price(xml, unit_price)
        xml['payu'].UnitPrice do
          xml['payu'].Net             unit_price.net_price
          xml['payu'].Gross           unit_price.gross_price
          xml['payu'].Tax             unit_price.tax_price
          xml['payu'].CurrencyCode    unit_price.currency_code

          generate_options(xml, unit_price)
        end
      end

      def build_shipping_cost(xml)
        xml['payu'].ShippingCost do
          xml['payu'].ShippingCostsUpdateUrl 
          xml['payu'].AvailableShippingCost do
            xml['payu'].ShippingCostList do
              @order.shipping_costs.each do |shipping_cost|
                shipping_cost_builder(xml, shipping_cost)
              end
            end # End ShippingCostList
            xml['payu'].CountryCode        "PL"
            xml['payu'].ShipToOtherCountry "false"
          end # End AvailableShippingCost
        end # End ShippingCost
      end

      def shipping_cost_builder(xml, shipping_cost)
        raise "TODO: Need to check and implement"
        xml['payu'].ShippingCost do
          xml['payu'].Price do
            xml['payu'].Net "100"
            xml['payu'].Gross "122"
            xml['payu'].Tax "22"
            xml['payu'].TaxRate "22"
            xml['payu'].CurrencyCode "PLN"
          end # End Price
          xml['payu'].Type "poczta"
        end # End ShippingCost
      end

      # Generate optional fields depending on object - methods that it responds 
      # and constante OPTIONAL defined in object class. 
      def generate_options(xml, obj)
        klass = obj.class
        klass::OPTIONAL.each do |mth|
          xml['payu'].send(mth.to_s.classify, obj.send(mth)) if obj.respond_to?(mth)
        end
      end

      # Unique id of the request
      def request_id
        # Wartość określająca unikalną wartość żądania
        @commission ||= Commission.create(:entity => @origin_order)
        @commission.req_id
      end

      # URL, to which PayU sends order and payment statuses and other messages
      def notify_url
        PayuRails.notify_url
      end

      # URL, to which PayU will redirect the user that wants to cancel his order
      def order_cancel_url
        PayuRails.order_cancel_url
      end

      # URL, to which PayU will redirect the user after the payment is complete
      def order_complete_url
        PayuRails.order_complete_url
      end

      # Customer IP
      def customer_ip
        @options[:customer_ip] || "127.0.0.1"
      end

      # Unique ID of point of sale/merchant in the transactional system of PayU
      def merchant_pos_id
        PayuRails.pos_id
      end

      # Unique ID the current order in the transactional system.
      def session_id
        request_id
      end

      # Authorization key of a POS/merchant
      def merchant_authorization_key
        PayuRails.pos_auth_key
      end
    end
  end
end
