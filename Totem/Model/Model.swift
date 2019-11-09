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
    
    let sentimento = ["cansado", "legal", "feliz", "bravo", "custom"]
    
    var usuario = Usuario(id: "UxzcHc7lR2YmGY0n4OEf")
    
    var totens: [Totem]! = []
    
    func getContatos() -> [ContatoDomain] {
        var contatos : [ContatoDomain] = []
        
        for contato in Model.instance.usuario.contatos! {
            contatos.append(ContatoDomain(contato: contato))
        }
        return contatos
    }
    
    func baixarInfos(contatoDomain: ContatoDomain){
        DAOFirebase.retornaTotens()
        DAOFirebase.retornaUsuario(id: usuario.id!)
        getMensagens(contatoDomain: contatoDomain)
        
    }
    
    func getMensagens(contatoDomain: ContatoDomain) {
        
        let usuario = contatoDomain.totemIDUsuario
        let contato = contatoDomain.totemIDContato
        
        let mensagensUsuario = DAOFirebase.buscarMensagens(field: "idCriador", id: usuario)
        let mensagensContato = DAOFirebase.buscarMensagens(field: "idPossuinte", id: contato!)
        
        var todasAsMensagens: [Mensagem] = []
        
        todasAsMensagens.append(contentsOf: mensagensUsuario)
        todasAsMensagens.append(contentsOf: mensagensContato)
        
        todasAsMensagens.sort(by: { $0.datadeEnvio > $1.datadeEnvio } )
        
        
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
