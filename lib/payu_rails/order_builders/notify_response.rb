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
                xml['payu'].ResId @commission.req_id

                xml['payu'].Status do
                  xml['payu'].StatusCode Utils::Mappings::RESPONSE_STATUSES.keys.first
                end
              end
            end
          end
        end
        
        @result
      end
    end
  end
end
