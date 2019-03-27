  Dado("que estou autenticado com {string} e {string}") do |email, senha|
    novo_usuario_api(email, senha)

    @login_page.acessa
    @login_page.logar(email,senha)
    expect(@contato_page.titulo).to eql 'Meus Contatos'
    @email_usr = email
    @contato_page.fecha_salert
  end

  Dado("que possuo o seguinte contato:") do |table|
    @novo_contato = table.rows_hash
  end

  Dado("já existe um contato cadastrado com este celular") do
    steps %(
      Quando faço o cadastro deste novo contato
    ) #reaproveita step
  end
  
  Quando("faço o cadastro deste novo contato") do
    @contato_page = ContatoPage.new
    @contato_page.visita
    @contato_page.salvar_contato(@novo_contato)
  end

  Então("devo ver a seguinte mensagem de alerta {string}") do |mensagem|
    expect(@contato_page.msg_alert_box).to have_content mensagem
  end
  
  Então("este contato não deve ser inserido no banco de dados") do
    res = DAO.new.busca_celular(@novo_contato[:celular])
    # eu espero que o celular seja nulo, ou seja, ele não encontrou o registro
    # fazendo um teste funcional com o teste de integração com db
    expect(res).to be_nil 
  end

  #Lista

  Dado("tenho a seguinte lista de contatos para cadastro:") do |table|
    @lista_contato = table.hashes
    @contato_page.visita

    @lista_contato.each do |contato|
      @contato_page.salvar_contato(contato)
    end
  end

  Dado("não possuo contatos cadastrados") do
    DAO.new.limpa_contatos(@email_usr)
  end
  
  Quando("acesso a minha agenda") do
    @contato_page.visita
  end

    
  Quando("solicito a exclusão deste contato") do
    @celular = @lista_contato.first[:celular]
    #quero um TR que contenha o mesmo valor que o celular e apague
    
    #find('tr', text: celular).find('#deletarContato').click

    @contato_page.remover_contato(@celular)
  end

  Quando("confirmo a exclusao") do
    @contato_page.confirma_modal
  end

  Quando("desisto da exclusão") do
    @contato_page.cancela_modal
  end

  Quando("faço o cadastro dos seguintes contatos:") do |table|
    @contatos = table.hashes

    @alertas = []

    @contatos.each do |c| # salva os contatos sequencialmente
      @contato_page.salvar_contato(c)
    end
    @alertas.push(@contato_page.msg_alert_box.text) #salva no array as mensagens de alerta
    @contato_page.fecha_salert
  end

  
  Então("devo ver estes registros na lista de contatos") do
    trs = @contato_page.retorna_trs

    @lista_contato.each_with_index do |valor, index|
      expect(trs[index]).to have_content valor[:nome]
      expect(trs[index]).to have_content valor[:email]
      expect(trs[index]).to have_content valor[:celular]
      expect(trs[index]).to have_content valor[:tipo]
    end

  end
    
  Então("devo ver a mensagem {string}") do |msg_alerta|
    expect(@contato_page.msg_alert_warning).to eql msg_alerta
  end

  Então("eu não devo ver este contato na minha agenda") do
    res = DAO.new.busca_celular(@celular)
    #espero que o celular seja nulo
    expect(res).to be_nil
  end
  
  Então("este contato permanece na minha agenda") do
    res = DAO.new.busca_celular(@celular)
    expect(res[:celular]).to eql @celular
  end
  
  Então("devo ver {string} como mensagem de alerta") do |msg_alerta|
    @alertas.each do |a|
      expect(a).to eql msg_alerta
    end
  end
  