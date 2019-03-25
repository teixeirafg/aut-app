module Comercio
  module MyOrders
    class MyOrders < SitePrism::Page

      def is_my_orders
        is_visible_el 'my_orders.is_my_orders'
      end

      def search_order order

      end

    end
  end
end

