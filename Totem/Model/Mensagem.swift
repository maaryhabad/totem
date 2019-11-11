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
    var url: String
    var audio = ""
    var datadeEnvio = ""
    var duracao :String = ""
    var de = "" //id do usuário
    var deNome :String = ""
    var para = "" //id do totem
    var salvo = false
    var visualizado = false
    
    init(url: String, audio: String, datadeEnvio: String, duracao: String, de: String, deNome :String, para: String, salvo: Bool, visualizado: Bool) {
        self.url = url
        self.audio = audio
        self.datadeEnvio = datadeEnvio
        self.duracao = duracao
        self.de = de
        self.deNome = deNome
        self.para = para
        self.salvo = salvo
        self.visualizado = visualizado
        self.id = ""
        
    }
    
//    init(id: String) {
//        self.id = id
//
//    }
    
    func mapToDictionary() ->[String: Any] {
        
        var mensagemData: [String:Any] = [:]
        
        mensagemData["url"] = self.url
        mensagemData["audio"] = self.audio
        mensagemData["datadeEnvio"] = self.datadeEnvio
        mensagemData["duracao"] = self.duracao
        mensagemData["de"] = self.de
        mensagemData["deNome"] = self.deNome
        mensagemData["para"] = self.para
        mensagemData["salvo"] = self.salvo
        mensagemData["visualizado"] = self.visualizado
        
        return mensagemData
    }

    
    static func mapToObject(mensagemData: [String: Any], id:String) -> Mensagem {

        let url :String = mensagemData["url"] as! String
        let audio: String = mensagemData["audio"] as! String
        let datadeEnvio: String = mensagemData["datadeEnvio"] as! String
        let duracao: String = mensagemData["duracao"] as! String
        let de: String = mensagemData["de"] as! String //converter para usuario
        let deNome :String = mensagemData["deNome"] as! String
        let para: String = mensagemData["para"] as! String //converter para totem
        let salvo: Bool = mensagemData["salvo"] as! Bool
        let visualizado: Bool = mensagemData["visualizado"] as! Bool

        let mensagem = Mensagem(url: url, audio: audio, datadeEnvio: datadeEnvio, duracao: duracao, de: de, deNome: deNome, para: para, salvo: salvo, visualizado: visualizado)

        return mensagem
    }
    
    static func pegarDuracao(resource: URL, filePath: String) -> String {
        let asset = AVURLAsset(url: resource)
        let duracaoDouble =  Double(CMTimeGetSeconds(asset.duration))
        
        let duracaoStr = NSString(format: "%.0f", duracaoDouble) as String
        let duracao = Int(duracaoStr)
        let tempo = Utils.toTimeString(segundos: duracao!)
        
        return tempo
    }
}


