module Comercio
  module Cart
    class Cart < SitePrism::Page

      def is_cart
        is_visible_el 'cart.is_cart_with_product'
      end

      def click_buy
        if IOS
          swipe_page_down 400
        end
        click_el 'cart.buy'
      end

      def hire_additional_service (service, additional_arg = '')
        service.downcase!
        if service.include? 'garantia'
          hire_warranty additional_arg
        elsif service.include? 'roubo'
          hire_keep_safe additional_arg
        else
          hire_service service
        end
      end

      private


      def hire_warranty warranty
        hire_service 'estendida'
        extended_warranty.choose_warranty warranty
      end

      def hire_keep_safe keep_safe
        hire_service 'roubo'
        extended_warranty.choose_keep_safe keep_safe
      end

      def hire_service service_name
        els = find_all_els 'cart.additional_services_box'

        if els.size > 0
          els.each do |el|
            if find_child_el(el, 'cart.additional_services_description').text.downcase.include? service_name.downcase
              find_child_el(el, 'cart.hire_additional_services').click
              break
            end
          end
        end
      end


    end
  end
end

