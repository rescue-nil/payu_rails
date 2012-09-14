require 'nokogiri'

module PayuRails
  module OrderBuilders
    class RetrieveRequest < Base
      attr_accessor :result, :commission

      def initialize(commission, *args)
        @commission    = commission
        @options       = args.extract_options!.symbolize_keys! || {}
      end

      def build
        # Building xml file depending on passed options, oredr object
        # and implemented adapters.
        @result = Nokogiri::XML::Builder.new :encoding => 'UTF-8' do |xml|
          xml.OpenPayU do
            # Correct namespace url
            xml.doc.root.namespace = xml.doc.root.add_namespace_definition('payu', Connection::OfficialPaths.xml_namepsace_url)

            # Building header
            build_header_request(xml)

            # Building content
            xml['payu'].OrderDomainRequest do
              xml['payu'].OrderRetrieveRequest do
                xml['payu'].ReqId               @commission.req_id
                xml['payu'].MerchantPosId       PayuRails.pos_id
                xml['payu'].SessionId           @commission.session_id
              end # OrderCRetrieveRequest
            end # OrderDomainRequest
          end # OpenPayU
        end # Nokogiri block

        @result
      end
    end
  end
end
