require_relative 'helpers'

World(Helpers) # deixa os metodos helpers como nativos, metodos globais

Before do
    @contato_page = ContatoPage.new
    @login_page = LoginPage.new
    @api_uri = $env_file[$env_type]['web']
end

After('@logout') do
    click_button 'Sair'
    page.has_css?('form[id=login]') #verifica se esta no formulario de login
    sleep 3
end

After ('@inserirContato') do
    res = DAO.new.busca_celular(@novo_contato[:celular])

    # eu espero que o nome registrado no banco seja igual com o da minha massa de testes
  
    expect(res[:nome]).to eql @novo_contato[:nome]
    expect(res[:email]).to eql @novo_contato[:email]
    expect(res[:celular]).to eql @novo_contato[:celular]
    expect(res[:tipo]).to eql @novo_contato[:tipo]
end

After do |scenario|
    nome = scenario.name.gsub(/[^A-Za-z0-9 ]/, '') #pega o nome de cenario e remove caracteres especiais em vazio
    nome = nome.tr(' ', '_').downcase! # inclui o _ nos espacos
    screenshot = "log/screenshots/#{nome}.png"
    page.save_screenshot(screenshot)
    embed(screenshot, 'image/png', 'Veja a evidência :)')
  end

