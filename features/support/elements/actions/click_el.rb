module ClickEl

  @description
  @finder
  @el_locator

  ##
  # ClickEl default tanto para desktop quanto para mobile
  def click_el(el, log = false)
    retries = 0
    begin
      element = find_el(el)
      element.click
    rescue StandardError

      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end

  def tap_el(el, log = false)
    retries = 0
    begin
      element = find_el(el)
      Appium::TouchAction.new.tap(element: element, x:0.5, y:0.5).perform
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end


  def click_first_el(el, log = false)
    retries = 0
    begin
      element = find_all_els(el)
      element.first.click
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end

  def swipe_and_click_el(el, log = false)
    retries = 0
    begin
      element = swipe_until_visible
      element.click
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end


  def click_el_random(el, log = false)
    retries = 0
    begin

      elements = find_all_els(el)
      if IOS
        elements.each do |el|
          if el.visible?
            el.click
            break
          end
        end
      else
        elements[rand(0...elements.size)].click
      end
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end

  def click_el_position(el, position, log = false)
    retries = 0
    begin
      elements = find_all_els(el)
      elements[position].click
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end


  def click_text_el(el, text, log = false)
    retries = 0
    ret = false
    text_list = []
    begin
      if IOS
        element = find_el_contains_text el, text
        element.click
      else
        elements = find_all_els(el)
        elements.each do |el|
          text_list << el.text
          next unless el.text == text
          ret = true
          el.click
        end


        unless ret
          error = "Nenhum elemento com o texto #{text} foi encontrado. Os textos presentados foram: #{text_list}"
          tracing_and_raise_error error
          raise error
        end

      end

    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end

  def click_contains_text_el(el, text, log = false)
    retries = 0
    ret = false
    text_list = []
    begin
      elements = find_all_els(el)
      elements.each do |el|
        text_list << el.text
        if el.text.downcase.include? text.downcase
          ret = true
          el.click
          break
        end
      end

      unless ret
        error = "Nenhum elemento com o texto #{text} foi encontrado. Os textos presentados foram: #{text_list}"
        tracing_and_raise_error error
        raise error
      end

    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        click_error_log el
      end
    end
  end



  private

  @description
  @finder
  @el_locator

  def define_finders(el_name)
    discover = DiscoverElement.new
    discover.discover(el_name)

    @description = discover.description
    @finder = discover.finder
    @el_locator = discover.element
  end

  def click_error_log el
    error = "Erro ao clicar no elemento " + el
    tracing_and_raise_error error
  end

end