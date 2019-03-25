module Comercio
  module Address
    class Address < SitePrism::Page

      def is_address
        is_visible_el 'address.is_address'
      end

      def click_buy
        click_el 'address.buy'
      end

      def choose_delivery delivery_type
        delivery_type.downcase!
        unless delivery_type == 'default'
          if delivery_type == 'random'
            click_el_random 'address.shipping_type'
          else

            if IOS
              case delivery_type.downcase!
              when 'normal'
                el = 'address.shipping_normal_ios'
              when 'agendada'
                el = 'address.shipping_agendada_ios'
              when 'expressa'
                el = 'address.shipping_expressa_ios'
              when 'super_expressa'
                el = 'address.shipping_super_expressa_ios'
              end
              unless is_visible_el el
                swipe_page_x
              end
              click_el el
            else
              els = find_all_els 'address.shipping_type'
              element = check_delivery els, delivery_type
              if element.nil?
                swipe_page_x
                els = find_all_els 'address.shipping_type'
                element = check_delivery els, delivery_type
              end

              if element.nil?
                false
              else
                element.click
                if delivery_type == 'agendada'
                  set_agendada
                end

                true
              end
            end
          end
        end
      end


      private

      def set_agendada
        tap_el 'address.open_schedule_date_list'
        click_el_random 'address.open_schedule_date_option'
        tap_el 'address.open_schedule_hour_list'
        click_el_random 'address.open_schedule_hour_option'
      end

      def check_delivery els, delivery_type
        element = nil
        els.each do |el|
          if el.text.downcase.include? delivery_type
            element = el
            break
          end
        end
        element
      end


    end
  end
end

