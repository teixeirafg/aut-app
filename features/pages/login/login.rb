module Comercio
  module Login
    class Login < SitePrism::Page

      def is_login
        is_visible_el 'login.is_login'
      end

      def do_login email, password
        send_keys_el 'login.email', email
        send_keys_el 'login.password', password
        click_el 'login.login_button'
      end
    end
  end
end

