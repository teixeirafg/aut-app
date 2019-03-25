#language: pt
#encoding: utf-8
@FullSmoke
@Search

Funcionalidade: Pesquisar produto

  - Narrativa:
  Efetuar pesquisa para possibilitar escolhas de itens futuros para compra


  Contexto: Acessar o APP
    Dado que estou na tela inicial do APP --HomePage


  Esquema do Cenario: Pesquisa válida
    Quando faço uma busca por "<search_term>" --HomePage
    Então verifico que a busca retornou resultados válidos --SearchPage

    Exemplos:
      | search_term |
      | camisa      |
