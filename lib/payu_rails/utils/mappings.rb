# encoding: UTF-8
module PayuRails
  module Utils
    module Mappings 
      ERROR_CODES = {
        100 => "Brak lub błędna wartość parametru MerchantPosId.",
        101 => "Brak lub błędna wartość parametru SessionId.",
        102 => "Brak lub błędna wartość parametru Timestamp.",
        103 => "Brak lub błędna wartość parametru HMAC.",
        104 => "Brak lub błędna wartość parametru OrderDescription.",
        105 => "Brak lub błędna wartość parametru BuyerIp.",
        115 => "Brak lub błędna wartość parametru OrderDate.",
        116 => "Brak lub błędna wartość k parametru UpdateUrl.",
        117 => "Brak lub błędna wartość parametru RqUId.",
        118 => "Brak lub błędna wartość parametru ValidityTime.",
        119 => "Brak typu Order.",
        120 => "Brak lub błędna wartość parametru UpdateUrl.",
        121 => "Brak typu ShoppingCart.",
        122 => "Brak typu Products.",
        123 => "Brak lub błędna wartość parametru GrandTotal.",
        124 => "Brak lub błędna wartość parametru CurrencyCode.",
        125 => "Brak lub błędna wartość parametru CountryCode.",
        126 => "Brak lub błędna wartość parametru ShippingCost.",
        127 => "Brak lub błędna wartość parametru ShippingTax.",
        128 => "Brak typu Product.",
        129 => "Brak lub błędna wartość parametru Name.",
        130 => "Brak lub błędna wartość parametru Quantity.",
        131 => "Brak lub błędna wartość parametru UnitPrice.",
        132 => "Brak lub błędna wartość parametru TaxRate.",
        200 => "Inny chwilowy błąd.",
        201 => "Inny chwilowy błąd bazy danych.",
        202 => "MerchantPos o podanym identyfikatorze jest zablokowany.",
        203 => "Niedozwolona metoda płatności dla danego MerchantPosId.",
        204 => "Podana metoda płatności jest chwilowo zablokowana dla danego MerchantPosId, np.  przerwa konserwacyjna bramki płatniczej.",
        205 => "Kwota transakcji mniejsza od wartości minimalnej.",
        206 => "Kwota transakcji większa od wartości maksymalnej.",
        207 => "Przekroczona wartość wszystkich transakcji dla jednego klienta w ostatnim przedziale czasowym.",
        208 => "MerchantPos działa w wariancie ExpressPayment, lecz nie nastąpiła aktywacja tego wariantu współpracy (czekamy na zgodę Działu Obsługi Klienta).",
        209 => "Błędny numer MerchantPosId lub PosAuthKey.",
        500 => "Transakcja nie istnieje.",
        501 => "Brak autoryzacji dla danej transakcji.",
        502 => "Transakcja rozpoczęta wcześniej.",
        503 => "Autoryzacja do transakcji była już przeprowadzana.",
        504 => "Transakcja anulowana wcześniej.",
        505 => "Transakcja przekazana do odbioru wcześniej.",
        506 => "Transakcja już odebrana.",
        507 => "Błąd podczas zwrotu środków do klienta.",
        599 => "Błędny stan transakcji, np. nie można uznać transakcji kilka razy lub inny – prosimy o kontakt.",
        999 => "Inny błąd krytyczny - prosimy o kontakt."
      }

      PAYMENT_STATUSES = {
        1     => "PAYMENT_STATUS_NEW",
        2     => "PAYMENT_STATUS_CANCEL",
        3     => "PAYMENT_STATUS_REJECT",
        4     => "PAYMENT_STATUS_INIT",
        5     => "PAYMENT_STATUS_SENT",
        6     => "PAYMENT_STATUS_NOAUTH",
        7     => "PAYMENT_STATUS_REJECT_DONE ",
        99    => "PAYMENT_STATUS_END",
        888   => "PAYMENT_STATUS_ERROR"
      }
    end
  end
end
