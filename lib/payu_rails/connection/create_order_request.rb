require 'openssl'
require 'net/http'
require 'net/https'
require 'cgi'

module PayuRails
  module Connection
    class CreateOrderRequest
      attr_accessor :xml

      def initialize(xml)
        @xml = xml
        self
      end

      def execute
        digest = Utils::Crypth.signature(@xml)
        headers = {
          "OpenPayu-Signature: sender" => PayuRails.pos_id.to_s,
          "signature" => digest,
          "algorithm" => PayuRails.default_algorithm,
          "content" => "DOCUMENT"
        }

        data_to_send = CGI::escape("#{@xml}")
        result  = post_data("DOCUMENT=#{data_to_send}", PayuRails.create_order_url, headers)
        parse_response(result)
      end

      def post_data(data, url, headers = nil)
        payu_service = Net::HTTP.new(PayuRails.domain_url, 443)
        payu_service.use_ssl = true
        payu_service.verify_mode = OpenSSL::SSL::VERIFY_NONE 
        response = payu_service.post(url, data.to_s, headers)
        response.body
      end

      def parse_response(xml_string)
        xml_doc = Nokogiri::XML(xml_string)
        xml_doc.remove_namespaces!
        status  = xml_doc.xpath("//StatusCode").text
        req_id  = xml_doc.xpath("//ResId").text
        
        commission = Commission.find_by_req_id(req_id)

        return false unless commission.present?

        return case status
          when "OPENPAYU_SUCCESS"
            commission.created!
            true
          when *Utils::Mappings::RESPONSE_STATUSES.keys
            commission.error!
            raise Errors::PaymentResponseError, "#{status}: #{xml_doc.xpath("//StatusDesc").text}"
          else
            commission.aborted!
            false
        end
      end
    end
  end
end
