//
//  Totem.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 18/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Totem {
    
    var id: String?
    var criador: Usuario? //é a pessoa que faz o totem
    var idCriador: String?
    var possuinte: Usuario? //é a pessoa que está com o totem
    var idPossuinte: String?
    var mensagens: [String]?
    var nome: String?
    var sentimento: Sentimento?
    
    init(criador: Usuario?, idCriador: String, possuinte: Usuario?, idPossuinte: String, mensagens: [String]?, nome: String, sentimento: Sentimento?) {
        self.criador = criador
        self.idCriador = idCriador
        self.possuinte = possuinte
        self.idPossuinte = idPossuinte
        self.mensagens = mensagens
        self.nome = nome
        self.sentimento = sentimento
    }
    
    init(id: String,  criador: Usuario?, idCriador: String, possuinte: Usuario?, idPossuinte: String, mensagens: [String]?, nome: String, sentimento: Sentimento?) {
        self.id = id
        self.criador = criador
        self.idCriador = idCriador
        self.possuinte = possuinte
        self.idPossuinte = idPossuinte
        self.mensagens = mensagens
        self.nome = nome
        self.sentimento = sentimento
    }
    
    func mapToDictionary() -> [String: Any] {
        var totemData: [String:Any] = [:]
            
        totemData["idCriador"] = self.idCriador
        totemData["idPossuinte"] = self.idPossuinte
        totemData["mensagens"] = self.mensagens
        totemData["nome"] = self.nome
        totemData["sentimento"] = self.sentimento
        
        return totemData
    }
    
    static func mapToObject(totemData: [String:Any], id :String) -> Totem {
        
        let idCriador = totemData["idCriador"] as! String
        let idPossuinte = totemData["idPossuinte"] as! String
        let mensagens: [String]? = totemData["mensagens"] as! [String]?
        let nome: String = totemData["nome"] as! String
//        let sentimento: Sentimento = totemData["sentimento"] as! Sentimento
        
        let totem = Totem(id: id, criador: nil, idCriador: idCriador, possuinte: nil, idPossuinte: idPossuinte, mensagens: mensagens, nome: nome, sentimento: nil)
        print(totem)
        return totem
    }
    
    func inserirMensagem(mensagem: Mensagem) {
        self.mensagens?.append(mensagem.id)
        DAOFirebase.updateTotemMensagens(totem: self)
    }
    
}
