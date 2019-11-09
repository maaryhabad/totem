//
//  Model.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 17/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
import AVFoundation

class Mensagem {
    var id: String
    var audio = ""
    var datadeEnvio = ""
    var duracao = ""
    var de = "" //id do usuário
    var para = "" //id do totem
    var salvo = false
    var visualizado = false
    
    init(audio: String, datadeEnvio: String, duracao: String, de: String, para: String, salvo: Bool, visualizado: Bool) {
        self.audio = audio
        self.datadeEnvio = datadeEnvio
        self.duracao = duracao
        self.de = de
        self.para = para
        self.salvo = salvo
        self.visualizado = visualizado
        self.id = ""
        
    }
    
    init(id: String) {
        self.id = id
        
    }
    
    func mapToDictionary() ->[String: Any] {
        
        var mensagemData: [String:Any] = [:]
        
        mensagemData["audio"] = self.audio
        mensagemData["datadeEnvio"] = self.datadeEnvio
        mensagemData["duracao"] = self.duracao
        mensagemData["de"] = self.de
        mensagemData["para"] = self.para
        mensagemData["salvo"] = self.salvo
        mensagemData["visualizado"] = self.visualizado
        
        return mensagemData
    }

    
    static func mapToObject(mensagemData: [String: Any]) -> Mensagem {

        let id: String = mensagemData["id"] as! String
        let audio: String = mensagemData["audio"] as! String
        let datadeEnvio: String = mensagemData["datadeEnvio"] as! String
        let duracao: String = mensagemData["duracao"] as! String
        let de: String = mensagemData["de"] as! String //converter para usuario
        let para: String = mensagemData["para"] as! String //converter para totem
        let salvo: Bool = mensagemData["salvo"] as! Bool
        let visualizado: Bool = mensagemData["visualizado"] as! Bool

        let mensagem = Mensagem(audio: audio, datadeEnvio: datadeEnvio, duracao: duracao, de: de, para: para, salvo: salvo, visualizado: visualizado)

        return mensagem
    }
    
    static func pegarDuracao(resource: URL, filePath: String) -> Double {
        let asset = AVURLAsset(url: resource)
        return Double(CMTimeGetSeconds(asset.duration))
    }
}


