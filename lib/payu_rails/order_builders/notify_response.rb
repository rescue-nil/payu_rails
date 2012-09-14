require 'nokogiri'

module PayuRails
  module OrderBuilders
    class NotifyResponse < Base
      attr_accessor :result

      # More at: http://www.payu.com/pl/openpayu/OrderDomainResponse.html
      def initialize(commission, *args)
        @commission    = commission
        @options       = args.extract_options!.symbolize_keys! || {}
      end

      def build
        @result = Nokogiri::XML::Builder.new :encoding => 'UTF-8' do |xml|
          xml.OpenPayU do
            # Correct namespace url
            xml.doc.root.namespace = xml.doc.root.add_namespace_definition('payu', Connection::OfficialPaths.xml_namepsace_url)

            # Building header
            build_header_response(xml)

            # Building content
            # Building content
            xml['payu'].OrderDomainResponse do
              xml['payu'].OrderNotifyResponse do
                xml['payu'].ResId     (@options[:req_id] || @commission.req_id)

                xml['payu'].Status do
                  xml['payu'].StatusCode correct_status
                end
              end
            end
          end
        end
        
        @result
      end

      private
      def correct_status
        if !@commission.present?
          "OPENPAYU_DATA_NOT_FOUND"
        elsif @commission.present? && @commission.correct_statuses?
          "OPENPAYU_SUCCESS" 
        else
          "OPENPAYU_ERROR_INTERNAL"
        end
      end
    end
  end
end
