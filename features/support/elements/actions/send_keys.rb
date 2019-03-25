module SendKeys

  # sendkeys básico
  def send_keys_el(el, value, log = false)
    begin
      retries ||= 0
      element = find_el(el)
      element.send_keys value
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        keys_error_log el, value
      end
    end
  end

  def send_keys_commands(command, el, log = false)
    begin
      retries ||= 0
      element = find_el(el)
      case command
      when 'enter'
        element.send_keys :enter
      end

    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        keys_error_log el, value
      end
    end
  end

  def send_keys_position(el, position, value, log = false)
    retries = 0
    begin
      elements = find_all_els(el)
      elements[position].send_keys value
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        keys_error_log el, value
      end
    end
  end


  def type_keys_el(el, value, log = false)
    begin
      retries ||= 0
      element = find_el(el)
      element.type value
    rescue StandardError
      retries += 1
      if retries < 3
        retry
      else
        keys_error_log el, value
      end
    end
  end


  def press_key_code(value, el=nil)
    if IOS
      send_keys_commands value, el
    else
      case value
      when 'enter'
        value = 66
      when 'numpad_enter'
        value = 160
      when 'search'
        value = 84
      when 'escape'
        value = 111
      end

      $driver.press_keycode value
    end
  end

  def press_key_code_sequence_text(value, log = false)
    sequence = {}
    sequence = value.split(//)

    sequence.length.times do |i|
      $driver.press_keycode key_code_map_alphanumeric sequence[i]
    end

  end

  def key_code_map_alphanumeric value
    value = value.downcase

    case value
    when '0'
      code = 7
    when '1'
      code = 8
    when '2'
      code = 9
    when '3'
      code = 10
    when '4'
      code = 11
    when '5'
      code = 12
    when '6'
      code = 13
    when '7'
      code = 14
    when '8'
      code = 15
    when '9'
      code = 16
    when 'a'
      code = 29
    when 'b'
      code = 30
    when 'c'
      code = 31
    when 'd'
      code = 32
    when 'e'
      code = 33
    when 'f'
      code = 34
    when 'g'
      code = 35
    when 'h'
      code = 36
    when 'i'
      code = 37
    when 'j'
      code = 38
    when 'k'
      code = 39
    when 'l'
      code = 40
    when 'm'
      code = 41
    when 'n'
      code = 42
    when 'o'
      code = 43
    when 'p'
      code = 44
    when 'q'
      code = 45
    when 'r'
      code = 46
    when 's'
      code = 47
    when 't'
      code = 48
    when 'u'
      code = 49
    when 'v'
      code = 50
    when 'w'
      code = 51
    when 'x'
      code = 52
    when 'y'
      code = 53
    when 'z'
      code = 54
    when ' '
      code = 62
    when ';'
      code = 74
    when '/'
      code = 76
    when '*'
      code = 17
    when ','
      code = 55
    when '.'
      code = 158
    end

    code
  end


  private

  def keys_error_log el, value
    error = "Erro ao enviar o texto: " + value + " para o elemento " + el
    tracing_and_raise_error error
  end


end