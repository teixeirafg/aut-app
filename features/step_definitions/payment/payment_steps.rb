Quando('levo um produto até a página de pagamento logado --PaymentPage') do |table|
  table.hashes.each do |row|
    step "faço uma busca por '#{row[:search_term]}' --HomePage"
    step 'seleciono o primeiro resultado apresentado --SearchPage'
    step 'clico em comprar --ProductDetailsPage'
    step 'fecho a tela de garantia estendida caso existir --ExtendedWarranty'
    step 'clico em comprar --CartPage'
    step "faço login com email '#{row[:email]}' e senha '#{row[:password]}' --LoginPage"
    step "e seleciono o tipo de entrega '#{row[:delivery_type]}' --AddressPage"
    step 'sigo para a tela de pagamento --AddressPage'
  end
end

Quando('levo dois produtos até a página de pagamento logado --PaymentPage') do |table|
  table.hashes.each do |row|
    step "faço uma busca por '#{row[:search_term]}' --HomePage"
    step 'seleciono o primeiro resultado apresentado --SearchPage'
    step 'clico em comprar --ProductDetailsPage'
    step 'fecho a tela de garantia estendida caso existir --ExtendedWarranty'
    step 'clico na aba de homepage --HomePage'
    step "faço uma busca por '#{row[:search_term2]}' --HomePage"
    step 'seleciono o primeiro resultado apresentado --SearchPage'
    step 'clico em comprar --ProductDetailsPage'
    step 'fecho a tela de garantia estendida caso existir --ExtendedWarranty'
    step 'clico em comprar --CartPage'
    step "faço login com email '#{row[:email]}' e senha '#{row[:password]}' --LoginPage"
    step "e seleciono o tipo de entrega '#{row[:delivery_type]}' --AddressPage"
    step 'sigo para a tela de pagamento --AddressPage'
  end
end



Quando('levo um produto com garantia estendida até a página de pagamento logado --PaymentPage') do |table|
  table.hashes.each do |row|
    step "faço uma busca por '#{row[:search_term]}' --HomePage"
    step 'seleciono o primeiro resultado apresentado --SearchPage'
    step 'clico em comprar --ProductDetailsPage'
    step "escolho a minha garantia estendida '#{row[:warranty]}' --ExtendedWarranty"
    step 'clico em comprar --CartPage'
    step "faço login com email '#{row[:email]}' e senha '#{row[:password]}' --LoginPage"
    step "e seleciono o tipo de entrega '#{row[:delivery_type]}' --AddressPage"
    step 'sigo para a tela de pagamento --AddressPage'
  end
end


E('levo o produto até a tela de pagamento --PaymentPage') do |table|
  table.hashes.each do |row|
    step 'clico em comprar --CartPage'
    step "faço login com email '#{row[:email]}' e senha '#{row[:password]}' --LoginPage"
    step "e seleciono o tipo de entrega '#{row[:delivery_type]}' --AddressPage"
    step 'sigo para a tela de pagamento --AddressPage'
  end
end

E('finalizo a compra com a opção de cartão de crédito para a bandeira {string} e parcelas randomicas --PaymentPage') do |bandeira|
  expecting(payment.is_payment, true, 'Verifica que está na tela de pagamento')
  payment.finish_payment_one_card bandeira, false
end

E('finalizo a compra com a opção de dois cartões de crédito para a bandeira {string} e bandeira {string} --PaymentPage') do |bandeira, bandeira2|
  expecting(payment.is_payment, true, 'Verifica que está na tela de pagamento')
  payment.finish_payment_two_cards bandeira, bandeira2
end


E('finalizo a compra com a opção de boleto --PaymentPage') do
  expecting(payment.is_payment, true, 'Verifica que está na tela de pagamento')
  payment.finish_payment_boleto
end
