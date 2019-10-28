//
//  Model.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 17/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Mensagem {
    var audio: URL
    var datadeEnvio: String
    var de: Usuario
    var idMensagem: String
    var para: Totem
    var salvo: Bool
    var visualizado: Bool
    
    init(audio: URL, datadeEnvio: String, de: Usuario, idMensagem: String, para: Totem, salvo: Bool, visualizado: Bool) {
        self.audio = audio
        self.datadeEnvio = datadeEnvio
        self.de = de
        self.idMensagem = idMensagem
        self.para = para
        self.salvo = salvo
        self.visualizado = visualizado
    }
    
    func mapToDictionary() ->[String: Any] {
        
        var mensagemData: [String:Any] = [:]
        
        mensagemData["audio"] = self.audio
        mensagemData["datadeEnvio"] = self.datadeEnvio
        mensagemData["de"] = self.de
        mensagemData["idMensagem"] = self.idMensagem
        mensagemData["para"] = self.para
        mensagemData["salvo"] = self.salvo
        mensagemData["visualizado"] = self.visualizado
        
        return mensagemData
    }
    
    static func mapToObject(mensagemData: [String: Any]) -> Mensagem {
        
        let audio: URL = mensagemData["audio"] as! URL
        let datadeEnvio: String = mensagemData["datadeEnvio"] as! String
        let de: Usuario = mensagemData["de"] as! Usuario
        let idMensagem: String = mensagemData["idMensagem"] as! String
        let para: Totem = mensagemData["para"] as! Totem
        let salvo: Bool = mensagemData["salvo"] as! Bool
        let visualizado: Bool = mensagemData["visualizado"] as! Bool
    }
}

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
}
