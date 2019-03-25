module Comercio
  module Account
    class Account < SitePrism::Page

      def register_new_user
        click_el 'account.register_link'
      end


      def check_logged_name
        logged_name = get_text_el 'account.username'
        if $name.downcase == logged_name.downcase
          true
        else
          false
        end
      end

    end
  end
end

