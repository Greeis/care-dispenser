#language: pt
@novo_contato
Funcionalidade: Novo Contato
    Sendo um usuario 
    Posso realizar um novo cadastro
    Para poder gerenciar minha rede de contatos

    @sprint1 @logout @inserirContato 
    Esquema do Cenario: Novo contato

        Dado que estou autenticado com "graziele@teste.io" e "123456"
        E que possuo o seguinte contato:
            | nome    | <nome>    |
            | email   | <email>   |
            | celular | <celular> |
            | tipo    | <tipo>    |
        Quando faço o cadastro deste novo contato
        Então devo ver a seguinte mensagem de alerta "Contato cadastrado com sucesso."

        Exemplos:
        |nome            |email             |celular   |tipo     |
        |Graziele Almeida|graziele@gmail.com|1199991001|Whats    |
        |Bruna Almeida   |bruna@gmail.com   |1199991002|Telegram |
        |Brenda Almeida  |brenda@gmail.com  |1199991003|SMS      |

    @sprint11 @logout
    Cenario: Lista de contatos

        Dado que estou autenticado com "graziele@teste.io" e "123456"
        Quando faço o cadastro dos seguintes contatos:
            | nome            | email             | celular     | tipo     |
            | Edson Almeida   | edson@gmail.com   | 1166991001  | Whats    |
            | Julieta Almeida | julieta@gmail.com | 1144991002  | Telegram |
            | Stela Almeida   | stela@gmail.com   | 1177991003  | SMS      |
            | Sonia Maria     | sonia@gmail.com   | 11989890000 | Whats    |
            | Yuki Almeida    | yuki@gmail.com    | 11787876565 | Telegram |
        Então devo ver "Contato cadastrado com sucesso." como mensagem de alerta

    @sprint2
    Esquema do Cenário: Campos obrigatórios

        Dado que estou autenticado com "graziele@teste.io" e "123456"
        E que possuo o seguinte contato:
            | nome    | <nome>    |
            | email   | <email>   |
            | celular | <celular> |
            | tipo    | <tipo>    |
        Quando faço o cadastro deste novo contato
        Então devo ver a seguinte mensagem de alerta "<mensagem>"


        Exemplos:
            | nome         | email            | celular    | tipo     | mensagem                                     |
            |              | teste@gmail.com  | 1199991006 | Whats    | Ops. O nome deve ser preenchido.             |  
            | Teste        |                  | 1199991007 | SMS      | Ops. O email deve ser preenchido.            |  
            | Peter Parker | teste1@gmail.com |            | Telegram | Ops. O celular deve ser preenchido.          |  
            | Scott Lang   | teste3gmail.com  | 1199991008 |          | Ops. Por favor selecione um tipo de contato. |

    @sprint3 @logout 
    Cenario: Celular não pode ser duplicado
        
        Dado que estou autenticado com "graziele@teste.io" e "123456"
        E que possuo o seguinte contato:
            | nome    | Graziele Almeida   |
            | email   | graziele@gmail.com |
            | celular | 11999990023        |
            | tipo    | Whats              |
        Mas já existe um contato cadastrado com este celular
        Quando faço o cadastro deste novo contato
        Então devo ver a seguinte mensagem de alerta "Celular já cadastrado."