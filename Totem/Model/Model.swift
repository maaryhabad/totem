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
        //print("baixar infos")
        //Baixar Usuário (com os contatos)
        DAOFirebase.retornaUsuario(userId: usuarioId){usuario in
            //print("\n\nRetorno de retornaUsuario")
            //print("nome: \(usuario.nome)")
            //print("qtde contatos: \(usuario.contatos)")
            //print("contatos: \(usuario.contatosID)")
            
            self.usuario = usuario
            
            //print(self.usuario.id, self.usuario.nome, self.usuario.imagem)
            DAOFirebase.retornaTotens()
        } //UxzcHc7lR2YmGY0n4OEf
//        //print("usuario pos inst: \(String(describing: self.usuario.nome))")
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
