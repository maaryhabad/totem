//
//  Model.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 17/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Mensagem {
    var audio: String
    var datadeEnvio: String
    var de: Int //id do usuário
    var idMensagem: String
    var para: Int //id do totem
    var salvo: Bool
    var visualizado: Bool
    
    init(audio: String, datadeEnvio: String, de: Int, idMensagem: String, para: Int, salvo: Bool, visualizado: Bool) {
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
        
        let audio: String = mensagemData["audio"] as! String
        let datadeEnvio: String = mensagemData["datadeEnvio"] as! String
        let de: Int = mensagemData["de"] as! Int
        let idMensagem: String = mensagemData["idMensagem"] as! String
        let para: Int = mensagemData["para"] as! Int
        let salvo: Bool = mensagemData["salvo"] as! Bool
        let visualizado: Bool = mensagemData["visualizado"] as! Bool
        
        let mensagem = Mensagem(audio: audio, datadeEnvio: datadeEnvio, de: de, idMensagem: idMensagem, para: para, salvo: salvo, visualizado: visualizado)
        
        return mensagem
    }
}
