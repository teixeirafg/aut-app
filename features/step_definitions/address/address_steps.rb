E('sigo para a tela de pagamento --AddressPage') do
  expecting(address.is_address, true, 'Verifica que está na pagina de endereço')
  address.click_buy
end




E('e seleciono o tipo de entrega {string} --AddressPage') do | delivery_type|
  address.choose_delivery delivery_type
end