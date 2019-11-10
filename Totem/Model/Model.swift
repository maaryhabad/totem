//
//  Model.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 18/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
import Firebase

class Model {
    static let instance = Model()
    
    private init() {
        
    }
    
    var usuarioId :String = "UxzcHc7lR2YmGY0n4OEf"
    var usuario = Usuario()
    var totens: [Totem]! = [] //Meus totens
    var contatos :[ContatoDomain]! = []
    
    func baixarInfos(){
        _ = DAOFirebase.retornaUsuario(userId: usuarioId){usuario in
            self.usuario = usuario
            print("\n\n================================================")
            print("Nome usuario: \(String(describing: self.usuario.nome))")
            
            if (self.usuario.contatosID!.count) > 0 {
                Usuario.populaContatos(contatosID: self.usuario.contatosID) { contatos in
                    self.usuario.contatos = contatos
                    print("Contatos usuario: \(String(describing: self.usuario.contatos?.count))")
                    
                    _ = DAOFirebase.retornaTotens(idCriador: self.usuarioId){totens in
                        self.totens = totens
                        print("Total totens: \(self.totens.count)")
                        
                        self.contatos = self.getContatos()
                        print("Total contatosDomain: \(self.contatos.count)")
                        print("================================================\n\n")
                    }
                }
            }
        }
    }
    
    func getContatos() -> [ContatoDomain] {
        var contatos : [ContatoDomain] = []
        
        for contato in Model.instance.usuario.contatos! {
            contatos.append(ContatoDomain(contato: contato))
        }
        return contatos
    }
    
    func getMensagens(contatoDomain: ContatoDomain) -> [MensagemDomain]{
        
        let usuario = contatoDomain.totemIDUsuario
        let contato = contatoDomain.totemIDContato
        
        let mensagensUsuario = DAOFirebase.buscarMensagens(field: "idCriador", id: usuario)
        let mensagensContato = DAOFirebase.buscarMensagens(field: "idPossuinte", id: contato!)
        
        var todasAsMensagens: [Mensagem] = []
        
        todasAsMensagens.append(contentsOf: mensagensUsuario)
        todasAsMensagens.append(contentsOf: mensagensContato)
        
        todasAsMensagens.sort(by: { $0.datadeEnvio > $1.datadeEnvio } )
        
        var msgsDomain :[MensagemDomain] = []
        for msg in todasAsMensagens{
            msgsDomain.append(MensagemDomain(msg: msg))
        }
        
        return msgsDomain
    }
    
    func getTotem(id: String) -> Totem! {
        //print("total totens: \(self.totens.count)")
        for totem in totens {
            //print("totem \(totem.id) ==  id \(id)")
            if id == totem.id {
                return totem
            }
        }
        return nil
    }
}

//criar as mensagens
