require 'mongo'

class DAO

    def busca_celular(celular)
        contatos.find('celular' => celular).first
    end

    def busca_nome(nome)
        contatos.find('nome' => nome).first
    end

    def delete_celular(celular)
        contatos.delete_many('celular' => celular)
    end

    def limpa_contatos(email_usuario)
        u = usuarios.find('emails.address' => email_usuario).first
        contatos.delete_many('dono' => u[:_id])
    end


    private
    def conecta
        Mongo::Logger.logger = Logger.new('log/mongo.log')
        client = Mongo::Client.new([ '127.0.0.1:3001' ], :database => 'meteor')
    end

    def contatos
        conecta[:contatos] # conecta a colecion contato
    end

    def usuarios
        conecta[:users]
    end
end