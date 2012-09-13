module PayuRails
  module OrderBuilders
    class Base
      attr_accessor :result

      def build_header(xml_builder)
        xml_builder['payu'].HeaderRequest do
          xml_builder['payu'].SenderName  PayuRails.pos_id
          xml_builder['payu'].Version     "1.0"
          xml_builder['payu'].Algorithm   PayuRails.default_algorithm
        end
      end
    end
  end
end
