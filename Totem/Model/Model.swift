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
    
    var usuarioId :String = "fAa4dnL8mmu8d1SgsD5u"//UxzcHc7lR2YmGY0n4OEf"
    var usuario = Usuario()
    var totens: [Totem]! = [] //Meus totens
    var contatos :[ContatoDomain]! = []
    
    var bleManager = BLEManager.instance
    
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
    
    func getMensagens(contatoDomain: ContatoDomain, completion: @escaping (([MensagemDomain])->())) -> [MensagemDomain] {
        
        let usuario = contatoDomain.totemIDUsuario
        let contato = contatoDomain.totemIDContato
        
        var mensagensUsuario :[Mensagem]!
        var mensagensContato :[Mensagem]!
        var todasAsMensagens: [Mensagem] = []
        var msgsDomain :[MensagemDomain] = []
        
        DAOFirebase.buscarMensagens(id: usuario){ mensagens in
            mensagensUsuario = mensagens

            DAOFirebase.buscarMensagens(id: contato!){mensagens in
                mensagensContato = mensagens
                
                todasAsMensagens.append(contentsOf: mensagensUsuario)
                todasAsMensagens.append(contentsOf: mensagensContato)
                todasAsMensagens.sort(by: { $0.datadeEnvio > $1.datadeEnvio } )

                for msg in todasAsMensagens{
                    msgsDomain.append(MensagemDomain(msg: msg))
                }
                completion(msgsDomain)
            }
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
