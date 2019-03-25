#language: pt
#encoding: utf-8


Funcionalidade: Finalizar compras - Garantia estendida

  - Narrativa:
  Finalizar compras com as posibilidades de:
  Comprar com garantia estendida


  Contexto: Acessar o APP
    Dado que estou na tela inicial do APP --HomePage

  Esquema do Cenario: Validar compra normal com cartão
    Quando levo um produto com garantia estendida até a página de pagamento logado --PaymentPage
      | search_term   | warranty   | email   | password   | delivery_type   |
      | <search_term> | <warranty> | <email> | <password> | <delivery_type> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira>" e parcelas randomicas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --ConfirmationPayment

    Exemplos:
      | search_term | warranty | email                                      | password | delivery_type | bandeira |
      | 13737331    | 12       | user_automacao03112014_090647492@cnova.com | 123456   | default       | random   |


  Esquema do Cenario: Garantia estendida e seguro contra roubo
    Quando levo um produto até o carrinho --CartPage
      | search_term   |
      | <search_term> |
    E contrato um seguro do tipo "garantia" na opção de "<option_garantia>" --CartPage
    E contrato um seguro do tipo "seguro roubo" na opção de "<option_roubo>" --CartPage
    E levo o produto até a tela de pagamento --PaymentPage
      | email   | password   | delivery_type   |
      | <email> | <password> | <delivery_type> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira>" e parcelas randomicas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --ConfirmationPayment

    Exemplos:
      | search_term | option_garantia | option_roubo | email                                      | password | delivery_type | bandeira |
      | 13737331    | 12              | quebra       | user_automacao03112014_090647492@cnova.com | 123456   | default       | random   |
