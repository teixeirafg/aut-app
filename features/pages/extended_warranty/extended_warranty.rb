module Comercio
  module ExtendedWarranty
    class ExtendedWarranty < SitePrism::Page


      def refuse_warranty
        if is_visible_el 'extended_warranty.refuse'
          click_el 'extended_warranty.refuse'
        end
      end

      def close_warranty_page
        if is_visible_el 'extended_warranty.refuse'
          click_el 'extended_warranty.close'
        end
      end


      def choose_warranty warranty
        if warranty.include? '12'
          warranty = '12'
        elsif warranty.include? '24'
          warranty = '24'
        elsif warranty.include? '36'
          warranty = '36'
        end

        unless warranty == 'default'
          click_el 'extended_warranty.open_list'

          if warranty == 'random'
            click_el_random 'extended_warranty.select_warranty'
          else
            click_contains_text_el 'extended_warranty.select_warranty', warranty
          end
        end
        click_el 'extended_warranty.accept'
      end

      def choose_keep_safe keep_safe
        keep_safe.downcase!
        if keep_safe.include?('roubo') && keep_safe.include?('quebra')
          keep_safe = 'roubo e furto qualificado + quebra acidental'
        elsif keep_safe.include? 'quebra'
          keep_safe = 'quebra acidental'
        elsif keep_safe.include? 'roubo'
          keep_safe = 'roubo e furto qualificado'
        end

        unless keep_safe == 'default'
          click_el 'extended_warranty.open_list'

          if keep_safe == 'random'
            click_el_random 'extended_warranty.select_warranty'
          else
            click_contains_text_el 'extended_warranty.select_warranty', keep_safe
          end
        end
        click_el 'extended_warranty.accept'
      end

    end
  end
end

