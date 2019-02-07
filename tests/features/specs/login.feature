#language: pt
@todo
Funcionalidade: Login
    Sendo um usuário já cadastrado
    Posso acessar o sistema com email e senha
    Para que somente eu possa ver meus contatos e gerenciar minha agenda

    Cenario: Login do usuário

        Dado que eu acesso a pagina principal
        Quando faço meu cadastro com "graaziele@gra.io" e senha "123456"
        Então sou autenticado com sucesso
    
    Cenario: Email não cadastrado

        Dado que eu acesso a pagina principal
        Quando faço login com email não cadastrado
        Então eu vejo a mensagem de alerta "Email e/ou senha incorretos"

    Cenario: Senha inválida

        Dado que eu acesso a pagina principal
        Quando faço login com senha incorreta
        Então eu vejo a mensagem de alerta "Email e/ou senha incorretos"