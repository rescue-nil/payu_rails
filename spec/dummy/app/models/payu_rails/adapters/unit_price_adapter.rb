module PayuRails
  module Adapters
    class UnitPriceAdapter < BaseAdapter
      OPTIONAL = [:tax_rate]

      CURRENCY_CODES = ["AED", "AFN", "ALL", "AMD", "ANG", "AOA", "ARS", "AUD", "AWG", "AZN", "BAM", "BBD", "BDT", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BOV",
                        "BRL", "BSD", "BTN", "BWP", "BYR", "BZD", "CAD", "CDF", "CHE", "CHF", "CHW", "CLF", "CLP", "CNY", "COP", "COU", "CRC", "CUC", "CUP", "CVE",
                        "CZK", "DJF", "DKK", "DOP", "DZD", "EGP", "ERN", "ETB", "EUR", "FJD", "FKP", "GBP", "GEL", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD",
                        "HNL", "HRK", "HTG", "HUF", "IDR", "ILS", "INR", "IQD", "IRR", "ISK", "JMD", "JOD", "JPY", "KES", "KGS", "KHR", "KMF", "KPW", "KRW", "KWD",
                        "KYD", "KZT", "LAK", "LBP", "LKR", "LRD", "LSL", "LTL", "LVL", "LYD", "MAD", "MDL", "MKD", "MMK", "MNT", "MOP", "MUR", "MVR", "MWK", "MXN",
                        "MXV", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD",
                        "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLL", "SOS", "SRD", "STD", "SYP", "SZL", "THB", "TJS", "TMT", "TND", "TOP",
                        "TRY", "TTD", "TWD", "TZS", "UAH", "UGX", "USD", "USN", "USS", "UYI", "UYU", "UZS", "VEF", "VND", "VUV", "WST", "XAF", "XAG", "XAU", "XBA",
                        "XBB", "XBC", "XBD", "XCD", "XDR", "XFU", "XOF", "XPD", "XPF", "XPT", "XTS", "XXX", "YER", "ZAR", "ZMK", "ZWL"]

      def initialize(obj)
        @obj = obj
        self
      end

      # REQUIRED
      # Net price expressed in the smallest moentary unit - e.g. grosz, cent, eurocent.
      def net_price
        5000
      end

      # REQUIRED
      # Gross price expressed in the smallest monetary unit - e.g. grosz, cent, eurocent. Gross=Net+Tax
      def gross_price
        10000
      end

      # REQUIRED
      # One of the CURRENCY_CODES
      def currency_code
        "PLN"
      end

      # REQUIRED
      def tax_price
        5000
      end

      # # OPTIONAL
      # # Tax rate expressed in %
      # def tax_rate
      #   not_yet
      # end

      private
      # Remember that price must be with comma not with dot.
      def price_with_comma(float)
        float.to_s.gsub('.', ',')
      end
    end
  end
end
