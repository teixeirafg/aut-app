E('o usuário é cadastrado com sucesso --AccountPage') do
  expecting(account.check_logged_name, true, 'Verifica que o login foi feito com sucesso')
end
