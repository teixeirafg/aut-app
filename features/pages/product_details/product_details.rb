module Comercio
  module ProductDetails
    class ProductDetails < SitePrism::Page

    def is_pdp
      is_visible_el 'product_details.is_pdp'

    end

    def buy
      swipe_page_down
      if IOS
        click_el_random 'product_details.buy_button'
      else
        click_el 'product_details.buy_button'
      end
    end




    end
  end
end

