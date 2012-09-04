module PayuRails
  module Errors
    class PaymentResponseError < StandardError
      def initialize(status)
        msg = Utils::Mappings::RESPONSE_STATUSES.include?(status) ? Utils::Mappings::RESPONSE_STATUSES[status] : status
        super(msg)
      end
    end
  end
end
