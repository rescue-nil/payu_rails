module PayuRails
  module Connection
    module OfficialPaths
      def self.xml_namepsace_url
        "http://www.openpayu.com/openpayu.xsd"
      end

      # Payu domain
      def self.domain_url
        "#{PayuRails.payu_env}.#{PayuRails.payu_domain}"
      end

      # Payu domain with http protocol and country
      def self.base_url
        "https://#{self.domain_url}"
      end

      def self.base_url_with_country
        "#{self.base_url}/#{PayuRails.payu_country}"
      end
      
      # Payu authorization paths
      def self.auth_url
        "#{base_url_with_country}/standard/oauth/authorize"
      end

      def self.user_auth_url
        "#{base_url_with_country}/standard/oauth/user/authorize"
      end

      def self.user_code_auth_url
        "#{base_url_with_country}/standard/user/oauth/authorize"
      end

      # Payu order managment paths
      def self.order_retrieve_request_url
        "#{base_url_with_country}/standard/co/openpayu/OrderRetrieveRequest"
      end

      def self.order_create_request_url
        "#{base_url_with_country}/standard/co/openpayu/OrderCreateRequest"
      end

      def self.order_status_update_request_url
        "#{base_url_with_country}/standard/co/openpayu/OrderStatusUpdateRequest"
      end

      def self.order_cancel_request_url
        "#{base_url_with_country}/standard/co/openpayu/OrderCancelRequest"
      end

      # Payu summary path
      def self.summary_url
        "#{base_url_with_country}/standard/co/summary"
      end
    end
  end
end
