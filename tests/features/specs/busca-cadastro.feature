#language: pt

@busca
Funcionalidade: Busca contato
    Sendo um usuário
    Posso buscar contatos pelo celular
    Para que seja fácil filtrar os dados da minha agenda

    Contexto: Lista para busca
        Dado que estou autenticado com "justica_@gmail.com" e "1234"
        E tenho a seguinte lista de contatos para cadastro:
            | nome            | email             | celular     | tipo     |
            | Edson Almeida   | edson@gmail.com   | 1166991001  | Whats    |
            | Julieta Almeida | julieta@gmail.com | 1144991002  | Telegram |
            | Stela Almeida   | stela@gmail.com   | 1177991003  | SMS      |
            | Sonia Maria     | sonia@gmail.com   | 11989890000 | Whats    |
            | Yuki Almeida    | yuki@gmail.com    | 11787876565 | Telegram |

    Cenario: Buscar pelo celular

        Quando faço a busca pelo celular "11989890000"
        Então devo somente o seguinte contato "Sonia Maria"

    Cenario: Dados não encotrados

        Quando faço a busca pelo celular "21999999999"
        Então devo ver a mensagem "Nenhum contato encontrato."