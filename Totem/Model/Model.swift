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
    
    func baixarInfos(){
        DAOFirebase.retornaTotens()
    }
    
    func getMensagens(contatoDomain: ContatoDomain) {
        //Objetivo: pegar as mensagens
        let usuario = contatoDomain.totemIDUsuario
        let contato = contatoDomain.totemIDContato
        
        let mensagensUsuario = DAOFirebase.buscarMensagens(field: "idCriador", id: usuario)
        let mensagensContato = DAOFirebase.buscarMensagens(field: "idPossuinte", id: contato!)
        
        var todasAsMensagens: [Mensagem] = []
        
        todasAsMensagens.append(contentsOf: mensagensUsuario)
        todasAsMensagens.append(contentsOf: mensagensContato)
        
        
        
        
        //Faria uma busca no banco de dados a partir do id pelo totem do criador na collection totem
        //Converter o retorno para Object
        //pegar o array de mensagens
        //Converter o array de Strings que vem do Banco para tipo Mensagem (ver conversão no modelo do Usuario)
        //retornar o array do tipo Mensagem
        //fazer a mesma coisa pro possuinte
        //organizar o array por data
    }
    
    func getTotem(id: String) -> Totem! {
        print("total totens: \(self.totens.count)")
        for totem in totens {
            print("totem \(totem.id) ==  id  \(id)")
            if id == totem.id {
                return totem
            }
        }
        return nil
    }
}

//criar as mensagens
