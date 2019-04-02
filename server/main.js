import { Meteor } from "meteor/meteor";
import { onPageLoad } from "meteor/server-render";
import { Mongo } from 'meteor/mongo';

Meteor.startup(() => {
  
  const Sintoma = new Mongo.Collection('sintomas');

  Meteor.methods({
    'inserirSintoma'(sintoma){
      var usuario = Meteor.user(); // traz as informações do usuario logado  
      var existe = Sintoma.findOne({ //verifica se já existe o sintoma no dia 
        tipo: sintoma.tipo, data: sintoma.data, dono: usuario._id, 
      });
      
      sintoma.dono = usuario._id; //quando é inserido um novo sintoma ele salva o id do usuario logado para vincular-lo com ele
      if(existe){
        throw new Meteor.Error(409, "Sintoma já cadastrado nesta data.")
      }else{
        Sintoma.insert(sintoma);  // cadastra o sintoma
      }
    },
    'removerSintoma'(sintomaID) {
      return Sintoma.remove({_id: sintomaID});
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
