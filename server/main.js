import { Meteor } from "meteor/meteor";
import { onPageLoad } from "meteor/server-render";
import { Mongo } from 'meteor/mongo';

Meteor.startup(() => {
  
  const Contato = new Mongo.Collection('contatos');

  Meteor.methods({
    'inserirContato'(contato){
      var usuario = Meteor.user(); // traz as informações do usuario logado  
      var existe = Contato.findOne({ //verifica se já existe o contato 
        celular: contato.celular, dono: usuario._id
      });
      
      contato.dono = usuario._id; //quando é inserido um novo contato ele salva o id do usuario logado para vincular-lo com ele
      if(existe){
        throw new Meteor.Error(409, "Celular já cadastrado.")
      }else{
        Contato.insert(contato);  // cadastra o contato
      }
    },
    'removerContato'(contatoID) {
      return Contato.remove({_id: contatoID});
    }
  })
});

onPageLoad(sink => {
  // Code to run on every request.
  sink.renderIntoElementById(
    "server-render-target",
    `Server time: ${new Date}`
  );
});
