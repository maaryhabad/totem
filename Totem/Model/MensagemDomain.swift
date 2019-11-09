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
    var date: Date
    
    init(primeiroNome: String, duracaoAudio: String, date: Date) {
        self.primeiroNome = primeiroNome
        self.duracaoAudio = duracaoAudio
        self.date = date
    }
    
}
