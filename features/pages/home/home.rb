module Comercio
  module Home
    class Home < SitePrism::Page

      def is_home
        is_visible_el 'home.is_home'
      end

      def accept_ios_remote_alerts
        if REMOTE
          if IOS
            if is_visible_el 'home.acceptGeoAlert_ios'
              click_el 'home.acceptGeoAlert_ios'
              if is_visible_el 'home.acceptNotifications_ios'
                click_el 'home.acceptNotifications_ios'
              end
            end
          end
        end
      end

      def make_search search_term
        $search_term = search_term
        click_el 'home.search_magnifier'
        send_keys_el 'home.search_bar', search_term
        press_key_code 'enter', 'home.search_bar'
      end

      def go_to_home
        click_el 'home.tabHome'
      end

      def go_to_my_account
        click_el 'home.accountHome'
      end

    end
  end
end

