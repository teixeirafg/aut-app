E('clico em comprar --ProductDetailsPage') do
  expecting(product_details.is_pdp, true, 'Verifica que está na PDP')
  product_details.buy
end