module PayuRails
  module Errors
    class StatusError < StandardError
      def initialize(status)
        msg = Utils::Mappings::PAYMENT_STATUSES.include?(status) ? Utils::Mappings::PAYMENT_STATUSES[status] : status
        super(msg)
      end
    end
  end
end
