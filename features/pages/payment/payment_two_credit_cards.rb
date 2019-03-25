module Comercio

  module PaymentTwoCreditCards
    class PaymentTwoCreditCards < SitePrism::Page

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
          raise msg
        end
      end

      def select_two_credit_cards
        if IOS
          click_text_el 'payment.text_reference', 'Cartão de Crédito'
        else
          click_text_el 'payment.choose_payment_type', 'Cartão de Crédito'
        end
        swipe_page_down
        if is_visible_el 'payment.choose_payment_with_two_cards'
          tap_el 'payment.choose_payment_with_two_cards'
        else
          raise 'Opção para segundo cartão não foi apresentada'
        end
      end

      def fill_first_credit_card_value
        hide_keyboard
        price = get_text_el 'payment.total_price'
        price = convert_price price
        value = price.to_f
        value = value / 2
        value = value.to_s.sub! '.', ''

        puts "Valor da divisão é: #{value}"

        tap_el 'payment.payment_with_two_cards_first_card_value'
        press_key_code_sequence_text value
      end


      def fill_two_cards card, card2
        fill_first_credit_card_value
        fill_credit_card card, 0
        choose_first_card_installments
        swipe_page_down 400
        fill_credit_card_two card2, 1
        choose_second_card_installments
      end


      def fill_credit_card card, position
        generate_card_info card
        click_el_position 'payment.one_credit_card_number', position
        press_key_code_sequence_text @card_num
        press_key_code 'enter'
        click_el_position 'payment.one_credit_card_name', position
        press_key_code_sequence_text @card_name
        press_key_code 'enter'
        click_el_position 'payment.one_credit_card_expiration_date', position
        press_key_code_sequence_text '022020'
        press_key_code 'enter'
        click_el_position 'payment.one_credit_card_cvv', position
        press_key_code_sequence_text @card_cvv
        press_key_code 'enter'
      end

      def fill_credit_card_two card, position
        generate_card_info card
        if check_elements_size 'payment.one_credit_card_number', 'equal', 2
          click_el_position 'payment.one_credit_card_number', position
        else
          click_el_position 'payment.one_credit_card_number', 0
        end
        press_key_code_sequence_text @card_num
        press_key_code 'enter'

        if check_elements_size 'payment.one_credit_card_name', 'equal', 2
          click_el_position 'payment.one_credit_card_name', position
        else
          click_el_position 'payment.one_credit_card_name', 0
        end
        press_key_code_sequence_text @card_name
        press_key_code 'enter'

        if check_elements_size 'payment.one_credit_card_expiration_date', 'equal', 2
          click_el_position 'payment.one_credit_card_expiration_date', position
        else
          click_el_position 'payment.one_credit_card_expiration_date', 0
        end
        press_key_code_sequence_text '022020'
        press_key_code 'enter'

        if check_elements_size 'payment.one_credit_card_cvv', 'equal', 2
          click_el_position 'payment.one_credit_card_cvv', position
        else
          click_el_position 'payment.one_credit_card_cvv', 0
        end
        press_key_code_sequence_text @card_cvv
        press_key_code 'enter'
      end

      def choose_first_card_installments
        # if is_visible_el 'payment.payment_with_two_cards_first_card_installment'
        #   click_el 'payment.payment_with_two_cards_first_card_installment'
        #   click_el_random 'payment.one_credit_card_choose_random_installment'
        #   tap_el 'payment.one_credit_card_ok_installments'
        # end
      end

      def choose_second_card_installments
        # if is_visible_el 'payment.payment_with_two_cards_second_card_installment'
        #   click_el 'payment.payment_with_two_cards_second_card_installment'
        #   click_el_random 'payment.one_credit_card_choose_random_installment'
        #   tap_el 'payment.one_credit_card_ok_installments'
        # end
      end


    end
  end


end