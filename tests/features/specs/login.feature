#language: pt
@login
Funcionalidade: Login
    Sendo um usuário já cadastrado
    Posso acessar o sistema com email e senha
    Para que somente eu possa ver meus contatos e gerenciar minha agenda

    Contexto: Home
        Dado que eu acesso a pagina principal
    @test @logout
    Cenario: Login do usuário

        Quando faço login com "graziele@teste.io" e "123456"
        Então sou autenticado com sucesso

    @tentativa_login
    Esquema do Cenario: Tentativa de login

        Quando faço login com '<email>' e '<senha>'
        Então vejo a seguinte mensagem de alerta '<saida>'
        
    Exemplos:
      | email             | senha   | saida                                       |
      | graziele@teste.io | xpto123 | Email e/ou senha incorretos.                |
      | graziele          | 123456  | Email e/ou senha incorretos.                |
      |                   |         | Preencha todos os campos com dados válidos. |