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
    
    init(criador: Usuario, possuinte: Usuario, mensagens: [Mensagem], nome: String, sentimento: Sentimento) {
        self.criador = criador
        self.possuinte = possuinte
        self.mensagens = mensagens
        self.nome = nome
        self.sentimento = sentimento
    }
    
    init(id: String) {
        self.id = id
    }
    
    
}
