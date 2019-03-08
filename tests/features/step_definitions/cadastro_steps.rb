Quando("faço meu cadastro com os seguintes dados:") do |table|
    @nome = table.rows_hash['nome']
    @email = table.rows_hash['email']
    @senha = table.rows_hash['senha']
    @login_page.cadastrar_usuario(@nome, @email, @senha)
end

Então("sou cadastradado com sucesso.") do
    @login_page.confirmaLogin
end

Então("vejo a mensagem de alerta {string}") do |mensagem|
    expect(@contato_page.msg_alert_box.text).to eql mensagem   
end
  