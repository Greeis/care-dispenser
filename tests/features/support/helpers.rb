require 'httparty'

module Helpers 
    
    def novo_usuario_api(email, senha)
        @api_uri = 'https://care-dispenser-api.herokuapp.com/api'
        HTTParty.delete( # chama a api e apaga essa conta
        # @env_file[@env_type]['web']
            @api_uri + "/users/#{email}"
        )
  
        @body = {
            name: 'Graziele',
            email: email,
            password: senha
          }

        # puts @body.class === o ruby cria um elemantpo do tipo hash sendo necessario converter para json

         HTTParty.post(
             @api_uri + '/users',
             body: @body.to_json,
             headers: { 'Content-Type' => 'application/json'}
       )
    end
end