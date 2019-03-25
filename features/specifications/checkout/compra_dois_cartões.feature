#language: pt
#encoding: utf-8

@FullSmoke
@Checkout
@TwoCards
Funcionalidade: Finalizar compras - Dois Cartões

  - Narrativa:
  Finalizar compras com as posibilidades de:
  Comprar com dois cartões


  Contexto: Acessar o APP
    Dado que estou na tela inicial do APP --HomePage

  Esquema do Cenario: Validar compra normal com cartão
    Quando levo um produto até a página de pagamento logado --PaymentPage
      | search_term   | email   | password   | delivery_type |
      | <search_term> | <email> | <password> | <delivery_type> |
    E finalizo a compra com a opção de dois cartões de crédito para a bandeira "<bandeira>" e bandeira "<bandeira2>" --PaymentPage
    Então confirmo que o número do pedido foi apresentado --ConfirmationPayment

    Exemplos:
      | search_term | email                                      | password | delivery_type | bandeira | bandeira2 |
      | 11799346  | user_automacao03112014_090647071@cnova.com | 123456   | default | random   | random    |


  Esquema do Cenario: Validar compra normal com cartão
    Quando levo dois produtos até a página de pagamento logado --PaymentPage
      | search_term   | search_term2 | email   | password   | delivery_type   |
      | <search_term> | <search_term2> | <email> | <password> | <delivery_type> |
    E finalizo a compra com a opção de dois cartões de crédito para a bandeira "<bandeira>" e bandeira "<bandeira2>" --PaymentPage
    Então confirmo que o número do pedido foi apresentado --ConfirmationPayment

    Exemplos:
      | search_term | search_term2 | email                                      | password | delivery_type | bandeira | bandeira2 |
      | 11799346    | 11458130  | user_automacao03112014_090647071@cnova.com | 123456   | default | random   | random    |
