E('cadastro um usuário PF randomicamente --RegisterPage') do
  registration.choose_legal_type 'pf'
  registration.fill_pf_random
  registration.fill_access_data_random
  registration.finish_registration
end

