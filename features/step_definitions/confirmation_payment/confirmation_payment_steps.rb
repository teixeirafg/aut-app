

E('confirmo que o número do pedido foi apresentado --ConfirmationPayment') do
  expecting(confirmation_payment.is_confirmation_payment, true, 'Verifica que está na tela de confirmação de pedido')
  mensagem_de_sucesso = confirmation_payment.get_order
  tracing mensagem_de_sucesso
end