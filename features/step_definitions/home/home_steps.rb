Quando('que estou na tela inicial do APP --HomePage') do
  home.accept_ios_remote_alerts
  expecting(home.is_home, true, 'está na tela inicial do APP')
end

Quando('faço uma busca por {string} --HomePage') do | produto |
  home.make_search produto
end

Quando('vou até a tela de cadastro --HomePage') do
  home.go_to_my_account
  account.register_new_user
end


Quando('clico na aba de homepage --HomePage') do
  home.go_to_home
end

