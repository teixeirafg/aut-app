module Comercio

  module PaymentCreditCard
    class PaymentCreditCard < SitePrism::Page

      @@cards = []
      @card_num
      @card_cvv
      @card_name


      def generate_card_info card
        card_file = load_card_file

        if card == 'random'
          @@cards = ["visa", "master", "american_express"]
          card = @@cards.shuffle.first
          @@cards.delete(card)
        end

        begin
          card_temp = "#{card_file['cartao_de_credito'][card]['numero']}"
          card_temp = card_temp.split(",")
          card_temp = card_temp[rand(0...card_temp.length)]
          @card_num = card_temp
          @card_cvv = "#{card_file['cartao_de_credito'][card]['cvv']}"
          @card_name = "#{card_file['cartao_de_credito'][card]['nome']}"
        rescue StandardError
          msg = 'Erro ao carregar as propriedades dentro do arquivo YML referente ao cartão de crédito'
          tracing_error msg
          raise msg
        end
      end

      def select_credit_card
        if IOS
          click_text_el 'payment.text_reference', 'Cartão de Crédito'
        else
          click_text_el 'payment.choose_payment_type', 'Cartão de Crédito'
        end
      end

      def fill_one_credit_card card, installments
        generate_card_info card
        if IOS
          send_keys_el 'payment.one_credit_card_number', @card_num
          click_el 'payment.done_button_ios'
          send_keys_el 'payment.one_credit_card_name', @card_name
          click_el 'payment.done_button_ios'
          send_keys_el 'payment.one_credit_card_expiration_date', '022020'
          click_el 'payment.done_button_ios'
          send_keys_el 'payment.one_credit_card_cvv', @card_cvv
          click_el 'payment.done_button_ios'
        else
          click_el 'payment.one_credit_card_number'
          press_key_code_sequence_text @card_num
          press_key_code 'enter'
          click_el 'payment.one_credit_card_name'
          press_key_code_sequence_text @card_name
          press_key_code 'enter'
          click_el 'payment.one_credit_card_expiration_date'
          press_key_code_sequence_text '022020'
          press_key_code 'enter'
          click_el 'payment.one_credit_card_cvv'
          press_key_code_sequence_text @card_cvv
          press_key_code 'enter'
        end

        if installments
          unless is_visible_el 'payment.one_credit_card_installments_modal'
            swipe_page_down
          end
          choose_installments
        end
      end

      def choose_installments
        if is_visible_el 'payment.one_credit_card_installments_modal'
          click_el 'payment.one_credit_card_installments_modal'
          click_el_random 'payment.one_credit_card_choose_random_installment'
          tap_el 'payment.one_credit_card_ok_installments'
        end
      end


    end
  end


end