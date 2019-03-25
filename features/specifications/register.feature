#language: pt
#encoding: utf-8

@FullSmoke
@Register

Funcionalidade: Registrar novo usuário

  - Narrativa:
  Cadastrar novos usuários para permitir compras


  Contexto: Acessar o APP
    Dado que estou na tela inicial do APP --HomePage


  Cenario: Cadastro Pessoa Fisica
    Quando vou até a tela de cadastro --HomePage
    E cadastro um usuário PF randomicamente --RegisterPage
    Então o usuário é cadastrado com sucesso --AccountPage
