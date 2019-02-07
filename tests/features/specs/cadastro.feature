#language: pt
@todo
Funcionalidade: Cadastro
    Sendo um usuario
    Posso fazer meu cadastro com email e senha
    Para que eu possa acessar minha agenda de contatos

    Cenario: Cadastro simples
    
        Dado que eu acesso a pagina principal
        Quando faço meu cadastro com "graaziele@gra.io" e senha "123456"
        Então sou autenticado com sucesso.

    Cenario: Usuário já cadastrado

        Dado que eu acesso a pagina principal
        Quando faço meu cadastro usando um email e senha já cadastrado
        Então vejo a mensagem de alerta "Você já está cadastrado."
