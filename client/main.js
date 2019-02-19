import { Template } from 'meteor/templating';
import { Mongo } from 'meteor/mongo';
import { Meteor } from 'meteor/meteor';

const Contato = new Mongo.Collection('contatos');

import './main.html'


Meteor.startup(function () {

    sAlert.config({
        effect: '',
        position: 'bottom',
        timeout: 5000
    })
})


// events = ações a usuario
//helper = informação para obter na tela 

Template.navbar.events({
    'click #btnSair'(event, instance) {
        event.preventDefault();
        Meteor.logout();
    }
})

Template.navbar.helpers({
    fullName() {
        return Meteor.user().profile.name; // retorna o nome do usuario da função do meteor account
    }
})

Template.acesso.events({

    'click #btnLogin'(event, instance) {
        event.preventDefault();

        var email = $('#loginEmail').val();
        var senha = $('#loginSenha').val();

        Meteor.loginWithPassword(email, senha, function (err) {
            if (err) {
                if (err.reason == 'Incorrect password') {
                    sAlert.error('Email e/ou senha incorretos.');
                    console.log(err.reason);
                } else if (err.reason == 'User not found'){
                    sAlert.error('Email e/ou senha incorretos.');
                    console.log(err.reason);
                    
                } else{
                    sAlert.error('Preencha todos os campos com dados válidos.');
                } 
            } else {
                sAlert.success('Olá, você foi autenticado.')
            }
        })

    },
    'click #btnCadastrar'(event, instance) {
        event.preventDefault();

        var nome = $('#cadastroNome').val();
        var email = $('#cadastroEmail').val();
        var senha = $('#cadastroSenha').val();

        var user = {
            email: email,
            password: senha,
            profile: { name: nome }
        }

        Accounts.createUser(user, function (err) {
            if (err) {
                if (err.reason = 'Email already exists.') {
                    sAlert.error('Você está cadastrado.');
                } else {
                    sAlert.error(err.reason);
                }
            } else {
                sAlert.success('Cadastro efetuado com sucesso');
            }
        })
    }

})

Template.listaContato.onCreated(function () { // quando ele criar uma lista ele executa esse código = construtor
    this.contatos = new ReactiveVar(Contato.find({ dono: Meteor.user()._id }));  //busca apenas os contatos do usuario
})


Template.listaContato.helpers({
    'minhaLista': function () {
        // var contatos = [
        //     { nome: 'Graziele', email: 'graziele@gmail.com', celular: '11999990909', tipo: 'SMS' },
        //     { nome: 'Bruna', email: 'bruna@gmail.com', celular: '11999990999', tipo: 'Whats' },
        //     { nome: 'Breno', email: 'breno@gmail.com', celular: '11999990966', tipo: 'Telegram' },
        //     { nome: 'Brenda', email: 'brenda@gmail.com', celular: '11999990988', tipo: 'SMS' }
        // ]
        // var contatos = Contato.find({dono: Meteor.user()._id}).fetch();

        return Template.instance().contatos.get();
    },
    'retornaIcone': function (tipo) {
        switch (tipo) {
            case 'Whats':
                return 'fa-whatsapp';
            case 'Telegram':
                return 'fa-telegram';
            case 'SMS':
                return 'fa-comment';
            default:
                null;
        }
    }
})


Template.listaContato.events({
    'click #btnBuscar'(event, instance) {
        event.preventDefault();

        var celular = $('#buscaCelular').val();

        var query = { dono: Meteor.user()._id };

        if (celular != '') {
            query.celular = celular;
        }

        var resultado = Contato.find(query);

        instance.contatos.set(resultado);

    },
    'click #deletarContato'(event, instance) {
        event.preventDefault();
        swal({
            title: 'Você tem certeza?',
            text: "Se confirmar, não terá volta.",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sim, pode apagar!',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.value) {
                Meteor.call('removerContato', this._id, function (err, res) {
                    if (err) {
                        sAlert.error(err.reason);
                        return false;
                    } else {
                        sAlert.success('Contato removido com sucesso.');
                    }
                })
            }
        })
    }
})


Template.novoContato.events({ // criando eventos
    'click #salvarContato'(event, instance) { // quando clicar no botão salvar contato
        event.preventDefault(); //cancela a execução assincrona.

        // pegando os dados do novo contato...criando obj json      

        var form = {
            nome: $('input[name=nome]').val(),
            email: $('input[name=email]').val(),
            celular: $('input[name=celular]').val(),
            tipo: $('select[name=tipo]').val()
        }
        console.log(form)

        if (form.nome == "") {
            sAlert.warning('Ops. O nome deve ser preenchido.')
            return false;
        } else if (form.email == "") {
            sAlert.warning('Ops. O email deve ser preenchido.')
            return false;
        } else if (form.celular == "") {
            sAlert.warning('Ops. O celular deve ser preenchido.')
            return false;
        } else if (form.tipo == null) {
            sAlert.warning('Ops. Por favor selecione um tipo de contato.')
            return false;
        }

        // Verificando

        Meteor.call('inserirContato', form, function (err, res) {
            if (err) {
                sAlert.error(err.reason)
            } else {
                sAlert.success('Contato cadastrado com sucesso.')
            }
        })
    }
});