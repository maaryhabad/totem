//
//  Model.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 17/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
import CloudKit

class Mensagem {
    var audio: AudioMensagem
    var datadeEnvio: Date
    var de: Usuario
    var idMensagem: Int
    var para: Totem
    var salvo: Int
    var visualizado: Int
    
    init(audio: AudioMensagem, datadeEnvio: Date, de: Usuario, idMensagem: Int, para: Totem, salvo: Int, visualizado: Int) {
        self.audio = audio
        self.datadeEnvio = datadeEnvio
        self.de = de
        self.idMensagem = idMensagem
        self.para = para
        self.salvo = salvo
        self.visualizado = visualizado
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}
