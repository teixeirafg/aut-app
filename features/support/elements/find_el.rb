module FindEl

  @page_name
  @description
  @finder
  @el_locator

  def define_finders(el_name)
    discover = DiscoverElement.new
    discover.discover(el_name)

    @description = discover.description
    @finder = discover.finder
    @el_locator = discover.element

    WaitPage.new
  end

  def find_el(el_name)
    retries = 0
    define_finders el_name
    begin
      wait_until_el_displayed @finder, @el_locator
      $driver.find_element(@finder, @el_locator)
    rescue StandardError
      wait_until_el_displayed @finder, @el_locator
      retries += 1
      if retries <= 1
        retry
      else
        find_el_log_error el_name
      end
    end
  end

  def find_el_contains_text(referece_el, text)
    retries = 0
    define_finders referece_el
    begin
      wait_until_el_displayed @finder, @el_locator
      $driver.find_element(:xpath, "//*[contains(@label, '#{text}')]")
    rescue StandardError
      wait_until_el_displayed @finder, @el_locator
      retries += 1
      if retries <= 1
        retry
      else
        find_el_log_error referece_el
      end
    end
  end

  def find_el_contains_text_no_ref(text)
    retries = 0
    begin
      $driver.find_element(:xpath, "//*[contains(@label, '#{text}')]")
    rescue StandardError
      retries += 1
      if retries <= 1
        retry
      else
        find_el_log_error text
      end
    end
  end


  def find_el_exists_contains_text(reference_el, text)
    define_finders reference_el
    begin
      wait_until_el_displayed @finder, @el_locator
      $driver.find_element(:xpath, "//*[contains(@label, '#{text}')]").displayed?
      true
    rescue StandardError
      false
    end
  end




  def find_child_el(element, el_name)
    retries = 0
    define_finders el_name
    begin
      wait_until_el_displayed @finder, @el_locator
      element.find_element(@finder, @el_locator)
    rescue StandardError
      wait_until_el_displayed @finder, @el_locator
      retries += 1
      if retries <= 3
        retry
      else
        find_el_log_error el_name
      end
    end
  end

  def find_el_exists(el_name)
    define_finders el_name
    begin
      wait_until_el_displayed @finder, @el_locator
      $driver.find_element(@finder, @el_locator).displayed?
      true
    rescue StandardError
      false
    end
  end



  def find_all_els(el_name)
    #WaitPage.new
    define_finders el_name
    retries = 0
    begin
      wait_until_elements_displayed @finder, @el_locator
      els = $driver.find_elements(@finder, @el_locator)

      if els.size == 0
        find_el_log_error el_name
      else
        els
      end
    rescue StandardError
      retries += 1
      if retries <= 3
        wait_until_el_displayed @finder, @el_locator
        retry
      else
        find_el_log_error el_name
      end
    end
  end

  private

  def find_el_log_error el_name
    error = "Elemento não encontrado: #{el_name}. Locator: #{@el_locator}. Descrição: #{@description}"
    tracing_and_raise_error error
  end

end