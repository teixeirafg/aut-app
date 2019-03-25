module Keyboard

 def hide_keyboard
   begin
   if $driver.is_keyboard_shown
     $driver.hide_keyboard
   end
   rescue Selenium::WebDriver::Error::UnknownError
   end
 end


end