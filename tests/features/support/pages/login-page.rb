class LoginPage
    include Capybara::DSL
    
    def acessa
        visit '/'
    end

    def logar(email, senha) 
        within('form[id=login]') do
            fill_in 'loginEmail', with: email
            fill_in 'loginSenha', with: senha
            click_button 'Entrar'
        end
    end

    def confirmaLogin
        find('#nomeUsuario')
    end

    def cadastrar_usuario(nome,email,senha)
        find('#cadastroNome').set nome
        find('#cadastroEmail').set email
        find('#cadastroSenha').set senha
        click_button 'Cadastrar'   
    end
end 