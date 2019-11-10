//
//  MensagemDomain.swift
//  totem
//
//  Created by Mariana Beilune Abad on 09/11/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class MensagemDomain {
    
    var primeiroNome = ""
    var duracaoAudio = ""
    var isVisualizado :Bool
    var dataEnvio: String
    var url :String
    
    init(msg :Mensagem) {
        self.primeiroNome = msg.deNome.split(separator: " ")[0].uppercased()
        self.duracaoAudio = msg.duracao
        self.isVisualizado = msg.visualizado
        self.dataEnvio = Utils.getDateString(date: msg.datadeEnvio)
        self.url = msg.url
    }
    
}
