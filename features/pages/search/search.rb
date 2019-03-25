module Comercio
  module Search
    class Search < SitePrism::Page

      def is_search_valid
        if is_visible_el 'search.products_found'
          true
        elsif $appium_driver.get_source.downcase.include? 'correu um erro ao carregar'
          home.go_to_home
          home.make_search $search_term
          is_visible_el 'search.products_found'
        else
          false
        end
      end

      def select_product
        click_first_el 'search.products_found'
      end

    end
  end
end

