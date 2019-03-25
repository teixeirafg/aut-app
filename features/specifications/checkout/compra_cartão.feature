#language: pt
#encoding: utf-8

@FullSmoke
@Checkout
@Card
Funcionalidade: Finalizar compras - Cartão

  - Narrativa:
  Finalizar compras com as posibilidades de:
  Comprar com um cartão


  Contexto: Acessar o APP
    Dado que estou na tela inicial do APP --HomePage

  Esquema do Cenario: Validar compra normal com cartão
    Quando levo um produto até a página de pagamento logado --PaymentPage
      | search_term   | email   | password   | delivery_type   |
      | <search_term> | <email> | <password> | <delivery_type> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira>" e parcelas randomicas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --ConfirmationPayment

    Exemplos:
      | search_term | email                                      | password | delivery_type | bandeira |
      | 13279095    | user_automacao03112014_090645433@cnova.com | 123456   | default       | random   |


  Esquema do Cenario: Validar compra normal com cartão
    Quando levo dois produtos até a página de pagamento logado --PaymentPage
      | search_term   | search_term2   | email   | password   | delivery_type   |
      | <search_term> | <search_term2> | <email> | <password> | <delivery_type> |
    E finalizo a compra com a opção de cartão de crédito para a bandeira "<bandeira>" e parcelas randomicas --PaymentPage
    Então confirmo que o número do pedido foi apresentado --ConfirmationPayment

    Exemplos:
      | search_term | search_term2 | email                                      | password | delivery_type | bandeira |
      | 13279095    | 13196230     | user_automacao03112014_090645433@cnova.com | 123456   | default       | random   |
