Dado("que eu acesso a pagina principal") do
    @login_page.acessa
end

Quando("faço login com {string} e {string}") do |email, senha|
    @login_page.logar(email,senha)
    sleep 2
end

Então("sou autenticado com sucesso") do
   @login_page.confirmaLogin
   @contato_page.fecha_salert
end
  
Então("vejo a seguinte mensagem de alerta {string}") do |mensagem|
    expect(@contato_page.msg_alert_box).to have_content mensagem
    @contato_page.fecha_salert
end