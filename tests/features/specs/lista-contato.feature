#language: pt
@lista
Funcionalidade: Lista contatos
    Sendo um usuário que possui contatos cadastrados
    Posso acessar a minha agenda
    Para que eu possa ver minha lista de contatos

    @sprint4 @logout
    Cenario: Listar contatos

        Dado que estou autenticado com "justica_@gmail.com" e "1234"
        E tenho a seguinte lista de contatos para cadastro:
            | nome     | email           | celular    | tipo     |
            | Sidimara | sidi@gmail.com  | 2199991001 | Whats    |
            | Edson    | edson@gmail.com | 2199991002 | Telegram |
        Quando acesso a minha agenda
        Então devo ver estes registros na lista de contatos
   
    @sprint5 @logout
    Cenario: Nenhum contato cadastrado

        Dado que estou autenticado com "graziele@teste.io" e "123456"
        E não possuo contatos cadastrados
        Quando acesso a minha agenda
        Então devo ver a mensagem "Nenhum contato encontrado."