E('fecho a tela de garantia estendida caso existir --ExtendedWarranty') do
  unless IOS
    extended_warranty.close_warranty_page
  end
end

E('escolho a minha garantia estendida {string} --ExtendedWarranty') do |warranty|
  extended_warranty.choose_warranty warranty
end