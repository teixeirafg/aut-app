module Comercio
  module PaymentBoleto
    class PaymentBoleto < SitePrism::Page

      def select_boleto
        if IOS
          click_text_el 'payment.text_reference', 'Boleto'
        else
          click_text_el 'payment.choose_payment_type', 'Boleto'
        end
      end

      def is_boleto
        if IOS
          true
        else
          is_visible_el 'payment.is_boleto'
        end
      end


    end
  end


end