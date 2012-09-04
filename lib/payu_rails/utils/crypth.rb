module PayuRails
  module Utils
    class Crypth
      def self.signature(xml)
        OpenSSL::Digest.hexdigest(PayuRails.default_algorithm.gsub(/[-]/, ''), "#{xml}#{PayuRails.client_secret_symetric}")
      end

      def self.uniq_token(string)
        Digest::SHA1.hexdigest(string)[0..16]     
      end
    end
  end
end
