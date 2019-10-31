//
//  Totem.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 18/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Totem {
    var criador: Usuario //é a pessoa que faz o totem
    var possuinte: Usuario //é a pessoa que está com o totem
    var mensagens: [String]
    var mensagensSalvas: [String]
    var nomeDoTotem: String
    var sentimento: [String]
    
    init(criador: Usuario, possuinte: Usuario, mensagens: [String], mensagensSalvas: [String], nomeDoTotem: String, sentimento: [String]) {
        self.criador = criador
        self.possuinte = possuinte
        self.mensagens = mensagens
        self.mensagensSalvas = mensagensSalvas
        self.nomeDoTotem = nomeDoTotem
        self.sentimento = sentimento
    }
    
    
}
