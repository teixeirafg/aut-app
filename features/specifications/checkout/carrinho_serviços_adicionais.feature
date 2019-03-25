#language: pt
#encoding: utf-8
@FullSmoke
@Cart
@CartAdditionalServices

Funcionalidade: Serviços adicionais - Carrinho

  - Narrativa:
  Contratar serviços adicionais no carrinho como:
  Garantia estendida, seguro contra roubo, instalação de tv, pacote office, etc


  Contexto: Acessar o APP
    Dado que estou na tela inicial do APP --HomePage


  Esquema do Cenario: Serviços de garantia
    Quando levo um produto até o carrinho --CartPage
      | search_term   |
      | <search_term> |
    Então contrato um seguro do tipo "<type>" na opção de "<option>" --CartPage

    Exemplos:
      | search_term | type     | option  |

  Esquema do Cenario: Serviços diversos
    Quando levo um produto até o carrinho --CartPage
      | search_term   |
      | <search_term> |
    Então contrato um serviço adicional de "<service>" --CartPage

    Exemplos:
      | search_term | service  |
      | 11799346    | instalação |
      | 13737331    | office |
