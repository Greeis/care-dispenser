import { Template } from 'meteor/templating';
import { Mongo } from 'meteor/mongo';
import { Meteor } from 'meteor/meteor';

const Sintoma = new Mongo.Collection('sintomas');

import './main.html'

Meteor.startup(function () {

    sAlert.config({
        effect: '',
        position: 'bottom',
        timeout: 5000
    })
})

Template.registerHelper('formatDate', function(date) {
    return moment(date).format('DD/MM/YYYY');
  });


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
                    document.getElementById('cadastroNome').value ="";
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

        if (user.profile.name == "") {
            sAlert.warning('Ops. O nome deve ser preenchido.')
            return false;
        } else if (user.email == "") {
            sAlert.warning('Ops. O email deve ser preenchido.')
            return false;
        } else if (user.password == "") {
            sAlert.warning('Ops. A senha deve ser preenchido.')
            return false;
        }

        Accounts.createUser(user, function (err) {
            if (err) {
                if (err.reason = 'Email already exists.') {
                    sAlert.error('Você está cadastrado.');
                    document.getElementById('cadastroNome').value ="";
                    document.getElementById('cadastroEmail').value ="";
                    document.getElementById('cadastroSenha').value ="";
                } else {
                    sAlert.error(err.reason);
                }
            } else {
                sAlert.success('Cadastro efetuado com sucesso');
            }
        })
    }

})

Template.listaSintoma.onCreated(function () { // quando ele criar uma lista ele executa esse código = construtor
    this.sintomas = new ReactiveVar(Sintoma.find({ dono: Meteor.user()._id }));  //busca apenas os sintomas do usuario
})


Template.listaSintoma.helpers({
    'minhaLista': function () {
        return Template.instance().sintomas.get();
    }
})

Template.listaSintoma.events({
    'click #btnBuscar'(event, instance) {
        event.preventDefault();

        var data = $('#buscaData').val();

        var query = { dono: Meteor.user()._id };

        if (data != '') {
            query.celular = data;
        }

        var resultado = Sintoma.find(query);

        instance.sintomas.set(resultado);

    },
    'click #deletarSintoma'(event, instance) {
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
                Meteor.call('removerSintoma', this._id, function (err, res) {
                    if (err) {
                        sAlert.error(err.reason);
                        return false;
                    } else {
                        sAlert.success('Sintoma removido com sucesso.');
                    }
                })
            }
        })
    }
})

Template.listaSintoma.rendered = function(){
    VMasker(this.find("[data-vm-mask-date]")).maskPattern("99/99/9999");
}

Template.novoSintoma.rendered = function(){
    VMasker(this.find("[data-vm-mask-date]")).maskPattern("99/99/9999");
    VMasker(this.find("[data-vm-mask-time]")).maskPattern("99:99");
    VMasker(this.find("[data-vm-mask-timer]")).maskPattern("99:99");
}

Template.novoSintoma.events({ // criando eventos
    'click #salvarSintoma'(event, instance) { // quando clicar no botão salvar Sintoma
        event.preventDefault(); //cancela a execução assincrona.

        // pegando os dados do novo Sintoma...criando obj json      
        var form = {
            tipo: $('#tipoSintoma').val(),
            data: $('#dataSintoma').val(),
            hora: $('#horarioSintoma').val(),
            duracao: $('#duracaoSintoma').val(),
        }
        console.log(form)


        if (form.tipo == null) {
            sAlert.warning('Ops. O tipo de sintoma deve ser informado.')
            return false;
        } else if (form.data == "") {
            sAlert.warning('Ops. A data do sintoma deve ser informada.')
            return false;
        } else if (form.hora == "") {
            sAlert.warning('Ops. O horário do sintoma deve ser informado.')
            return false;
        } else if (form.duracao == "") {
            sAlert.warning('Ops. O tempo de duração deve ser informado.')
            return false;
        }

        // Verificando

        Meteor.call('inserirSintoma', form, function (err, res) {
            if (err) {
                sAlert.error(err.reason)
            } else {
                sAlert.success('Sintoma cadastrado com sucesso.');
                document.getElementById('tipoSintoma').value ="";
                document.getElementById('dataSintoma').value ="";
                document.getElementById('horarioSintoma').value ="";
                document.getElementById('duracaoSintoma').value ="";
            }
        })
    }
});