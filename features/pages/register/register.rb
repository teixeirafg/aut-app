module Comercio
  module Register
    class Register < SitePrism::Page

    def choose_legal_type legal_type
      click_el 'register.legal_type'

      case legal_type.downcase
      when 'pf'
        click_el_position 'register.legal_type_options', 0
      when 'pj'
        click_el_position 'register.legal_type_options', 1
      end
    end

    def fill_pf_random
      $name = random_data('random', 'NAME')
      $last_name = random_data('random', 'NAME')
      send_keys_el 'register.full_name', "#{$name} #{$last_name}"
      click_el 'register.genre'
      click_el_random 'register.genre_options'
      send_keys_el 'register.cpf', random_data('random', 'cpf')
      swipe_page_down
      click_el 'register.birthday'
      unless IOS
        if is_visible_el 'register.close_android_date_picker_birthday'
          click_el 'register.close_android_date_picker_birthday'
        end
      end

      send_keys_el 'register.birthday', '02021980'
      send_keys_el 'register.phone', '11988439829'

    end

    def fill_access_data_random
      swipe_page_down
      final_email = random_data('random', 'email')
      send_keys_el 'register.email', final_email
      send_keys_el 'register.confirmation_email', final_email
      send_keys_el 'register.password', 'Varejo123'
      send_keys_el 'register.confirmation_password', 'Varejo123'
    end

    def finish_registration
      swipe_page_down
      click_el 'register.finish_registration'
    end

    end
  end
end













