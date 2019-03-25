#language: pt
#encoding: utf-8
@FullSmoke
@Checkout
@Boleto

Funcionalidade: Finalizar compras - Boleto

  - Narrativa:
  Finalizar compras com as posibilidades de:
  Comprar com boleto bancário


  Contexto: Acessar o APP
    Dado que estou na tela inicial do APP --HomePage


  Esquema do Cenario: Validar compra normal com boleto
    Quando levo um produto até a página de pagamento logado --PaymentPage
      | search_term   | email   | password   | delivery_type   |
      | <search_term> | <email> | <password> | <delivery_type> |
    E finalizo a compra com a opção de boleto --PaymentPage
    Então confirmo que o número do pedido foi apresentado --ConfirmationPayment

    Exemplos:
      | search_term | email                                      | password | delivery_type |
      | 13737331    | vv_qa_automacao@gmail.com                  | Varejo123   | normal        |

  Esquema do Cenario: Validar compra de dois produtos com boleto
    Quando levo dois produtos até a página de pagamento logado --PaymentPage
      | search_term   | search_term2   | email   | password   | delivery_type   |
      | <search_term> | <search_term2> | <email> | <password> | <delivery_type> |
    E finalizo a compra com a opção de boleto --PaymentPage
    Então confirmo que o número do pedido foi apresentado --ConfirmationPayment

    Exemplos:
      | search_term | search_term2 | email                                      | password | delivery_type |
      | 13737331    | 11799346     | user_automacao03112014_090647321@cnova.com | 123456   | random        |


