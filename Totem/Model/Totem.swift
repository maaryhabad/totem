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
    var possuinte: Usuario? //é a pessoa que está com o totem
    var mensagens: [Mensagem]?
    var nome: String?
    var sentimento: Sentimento?
    
    init(criador: Usuario?, possuinte: Usuario?, mensagens: [Mensagem]?, nome: String, sentimento: Sentimento?) {
        self.criador = criador
        self.possuinte = possuinte
        self.mensagens = mensagens
        self.nome = nome
        self.sentimento = sentimento
    }
    
    init(id: String) {
        self.id = id
    }
    
    func mapToDictionary() -> [String: Any] {
        var totemData: [String:Any] = [:]
            
        totemData["criador"] = self.criador
        totemData["possuinte"] = self.possuinte
        totemData["mensagens"] = self.mensagens
        totemData["nome"] = self.nome
        totemData["sentimento"] = self.sentimento
        
        return totemData
    }
    
    static func mapToObject(totemData: [String:Any]) -> Totem {
        
        let criador: Usuario = totemData["criador"] as! Usuario //fazer todas essas conversões
        let possuinte: Usuario = totemData["possuinte"] as! Usuario
        let mensagens: [Mensagem] = totemData["mensagens"] as! [Mensagem]
        let nome: String = totemData["nome"] as! String
        let sentimento: Sentimento = totemData["sentimento"] as! Sentimento
        
        let totem = Totem(criador: criador, possuinte: possuinte, mensagens: mensagens, nome: nome, sentimento: sentimento)
        print(totem)
        return totem
    }
    
}
