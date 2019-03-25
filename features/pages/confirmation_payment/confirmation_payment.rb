module Comercio
  module ConfirmationPayment
    class ConfirmationPayment < SitePrism::Page

      def is_confirmation_payment
        bool = is_visible_el 'confirmation_payment.is_confirmation_payment'
        if IOS
          click_el 'confirmation_payment.not_now'
        end
        bool

      end

      def get_order
        if IOS
          el = find_el_contains_text_no_ref 'O número do seu pedido'
          order_number = el.text
        else
          order_number = get_text_el 'confirmation_payment.get_order_number'
        end
        order_number
      end

      def go_to_my_orders
        click_el 'confirmation_payment.go_to_my_orders'
      end

    end
  end
end

