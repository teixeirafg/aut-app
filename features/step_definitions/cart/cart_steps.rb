E('clico em comprar --CartPage') do
  step 'verifico que estou no carrinho --CartPage'
  cart.click_buy
end

E('verifico que estou no carrinho --CartPage') do
  expecting(cart.is_cart, true, 'Verifica que está no carrinho')
end


E('contrato um serviço adicional de {string} --CartPage') do | service|
  cart.hire_additional_service service
end

E('contrato um seguro do tipo {string} na opção de {string} --CartPage') do | service, option|
  cart.hire_additional_service service, option
end



Quando('levo um produto até o carrinho --CartPage') do |table|
  table.hashes.each do |row|
    step "faço uma busca por '#{row[:search_term]}' --HomePage"
    step 'seleciono o primeiro resultado apresentado --SearchPage'
    step 'clico em comprar --ProductDetailsPage'
    step 'fecho a tela de garantia estendida caso existir --ExtendedWarranty'
  end
end


Quando('levo dois produtos até o carrinho --CartPage') do |table|
  table.hashes.each do |row|
    step "faço uma busca por '#{row[:search_term]}' --HomePage"
    step 'seleciono o primeiro resultado apresentado --SearchPage'
    step 'clico em comprar --ProductDetailsPage'
    step 'fecho a tela de garantia estendida caso existir --ExtendedWarranty'
    step 'verifico que estou no carrinho --CartPage'
    step 'clico na aba de homepage --HomePage'
    step "faço uma busca por '#{row[:search_term2]}' --HomePage"
    step 'seleciono o primeiro resultado apresentado --SearchPage'
    step 'clico em comprar --ProductDetailsPage'
    step 'fecho a tela de garantia estendida caso existir --ExtendedWarranty'
  end
end