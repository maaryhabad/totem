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
        
    var usuario = Usuario(id: "UxzcHc7lR2YmGY0n4OEf")
    
    var totens: [Totem]! = []
    
    func getContatos() -> [ContatoDomain] {
        var contatos : [ContatoDomain] = []
        
        for contato in Model.instance.usuario.contatos! {
            contatos.append(ContatoDomain(contato: contato))
        }
        return contatos
    }
    
    func baixarInfos(){
        //Baixar Usuário (com os contatos)
        print("baixar infos")
        Utils.getDateString(date: "20191109172029")
        
//        DAOFirebase.retornaTotens()
//        DAOFirebase.retornaUsuario(id: usuario.id!)
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
        print("total totens: \(self.totens.count)")
        for totem in totens {
            print("totem \(totem.id) ==  id \(id)")
            if id == totem.id {
                return totem
            }
        }
        return nil
    }
}

//criar as mensagens
