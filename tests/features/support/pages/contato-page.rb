# Page Object

class ContatoPage
    include Capybara::DSL
    
    def visita
        visit '/'
    end

    def salvar_contato (contato)
        find('input[placeholder="Nome completo"').set contato[:nome]
        find('#email').set contato[:email]
        find('input[data-test=celular]').set contato[:celular]

        if contato[:tipo] != ''
        tipo_contato = find('#tipo')
        tipo_contato.find('option', text: contato[:tipo]).select_option
        end

        click_on 'Adicionar Contato'
    end

    def titulo
        find('section[id=meusContatos] h4').text
    end

    def remover_contato(celular)
        find('tr', text: celular).find('#deletarContato').click
    end

    def confirma_modal
        find('.swal2-confirm').click
    end
    
    def cancela_modal
        find('.swal2-cancel').click
    end

    def msg_alert_box
        find('.s-alert-box')
    end

    def msg_alert_info
        find('.alert-info').text
    end

    def msg_alert_warning
        find('.alert-warning').text
    end

    def fecha_salert
        find('.s-alert-close').click
    end

    def retorna_trs
        all('.table tr')
    end
end