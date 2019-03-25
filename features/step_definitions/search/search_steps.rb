E('seleciono o primeiro resultado apresentado --SearchPage') do
  expecting(search.is_search_valid, true, 'Verifica que busca retornou resultados válidos')
  search.select_product
end


E('verifico que a busca retornou resultados válidos --SearchPage') do
  expecting(search.is_search_valid, true, 'Verifica que busca retornou resultados válidos')
end