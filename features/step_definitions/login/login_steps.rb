Quando('faço login com email {string} e senha {string} --LoginPage') do | email, password |
  expecting(login.is_login, true, 'Está na página de login')
  delete_sku_cart_api email, password
  login.do_login email, password
end
