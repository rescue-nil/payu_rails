module PayuRails
  module Errors
    class RespondError < StandardError
      def initialize(code)
        msg = Utils::Mappings::ERROR_CODES.include?(code) ? Utils::Mappings::ERROR_CODES[code] : code
        super(msg)
      end
    end
  end
end
