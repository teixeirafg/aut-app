module CheckData

  def get_text_el el
    element = find_el el
    element.text
  end

  def get_attribute_el (el, attr)
    attribute = find_el_attr el, attr
    attribute
  end


  def get_elements_size (el)
    elements = find_all_els(el)
    elements.size
  end

  def check_elements_size (el, compare, size)
    elements = find_all_els(el)
    el_size = elements.size
    case compare
    when 'higher'
      bool = el_size > size
    when 'higher_equal'
      bool = el_size >= size
    when 'equal'
      bool = el_size == size
    when 'lower'
      bool = el_size < size
    when 'lower_equal'
      bool = el_size < size
    end
    bool
  end

  def check_page_text (text)
    page.has_content? text
  end



end