module WaitElement

  def waiting

  end

  def wait_until_el_displayed(finder, el, seconds = 2)
    begin
      options = {}
      options[:timeout] ||= seconds
      wait = Selenium::WebDriver::Wait.new(options)
      element = wait.until {
        element = $driver.find_element(finder, el)
      }
      element if element.displayed?
    rescue Selenium::WebDriver::Error
    end
  end

  def wait_until_elements_displayed(finder, el, seconds = 2)
    begin
      options = {}
      options[:timeout] ||= seconds
      wait = Selenium::WebDriver::Wait.new(options)
      element = wait.until {
        element = $driver.find_elements(finder, el)
      }
      element if element.size > 0
    rescue Selenium::WebDriver::Error
    end
  end

end