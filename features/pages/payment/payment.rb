module Comercio
  module Payment
    class Payment < SitePrism::Page

      def is_payment
        is_visible_el 'payment.is_payment'
      end

      def finish_payment_one_card card, installments
        payment_credit_card.select_credit_card
        payment_credit_card.fill_one_credit_card card, installments
        finish_payment_button
      end

      def finish_payment_two_cards card, card2
        payment_two_credit_cards.select_two_credit_cards
        payment_two_credit_cards.fill_two_cards card, card2
        finish_payment_button
      end

      def finish_payment_boleto
        payment_boleto.select_boleto
        if payment_boleto.is_boleto
          finish_payment_button
        end
      end

      def finish_payment_button
        if IOS
          swipe_page_down 600
          is_visible_el 'payment.finish_payment'
        end
        tap_el 'payment.finish_payment'
      end

    end
  end
end

