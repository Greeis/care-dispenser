#language: pt
@cadastro
Funcionalidade: Cadastro
    Sendo um usuario
    Posso fazer meu cadastro com nome, email e senha
    Para que eu possa acessar minha agenda de contatos

    Contexto: Home
        Dado que eu acesso a pagina principal
    
    @teste1
    Cenario: Cadastro simples
    
        Quando faço meu cadastro com os seguintes dados:
            | nome  | Graziele       |
            | email | grazi@teste.io |
            | senha | 123456         |
        Então sou cadastradado com sucesso.

    @teste2
    Cenario: Usuário já cadastrado

        Quando faço meu cadastro com os seguintes dados:
            | nome  | Graziele       |
            | email | grazi@teste.io |
            | senha | 123456         |
        Então vejo a mensagem de alerta "Você está cadastrado."
    
    @tentativa_cadastro
    Esquema do Cenario: Tentativa de cadastro

        Quando faço meu cadastro com os seguintes dados:
            | nome  | <nome>  |
            | email | <email> |
            | senha | <senha> |
        Então vejo a seguinte mensagem de alerta '<mensagem>'
        
    Exemplos:
    |nome       | email          | senha   | mensagem                          |
    |           | grazi@teste.io | 123456  | Ops. O nome deve ser preenchido.  |
    |Graziele   |                | 123456  | Ops. O email deve ser preenchido. |
    |Graziele   | grazi@teste.io |         | Ops. A senha deve ser preenchido. |
