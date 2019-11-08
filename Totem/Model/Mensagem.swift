//
//  Model.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 17/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Mensagem {
    var id: String
    var audio: String?
    var datadeEnvio: String?
    var de: String? //id do usuário
    var para: String? //id do totem
    var salvo: Bool?
    var visualizado: Bool?
    
    init(audio: String, datadeEnvio: String, de: String, para: String, salvo: Bool, visualizado: Bool) {
        self.audio = audio
        self.datadeEnvio = datadeEnvio
        self.de = de
        self.para = para
        self.salvo = salvo
        self.visualizado = visualizado
        self.id = ""
        //salvar no firebase e recuperar id
    }
    
    init(id: String) {
        self.id = id
        
        //buscar no firebase
        //recuperar as informações
    }
    
    func mapToDictionary() ->[String: Any] {
        
        var mensagemData: [String:Any] = [:]
        
        mensagemData["audio"] = self.audio
        mensagemData["datadeEnvio"] = self.datadeEnvio
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
        let de: String = mensagemData["de"] as! String //converter para usuario
        let para: String = mensagemData["para"] as! String //converter para totem
        let salvo: Bool = mensagemData["salvo"] as! Bool
        let visualizado: Bool = mensagemData["visualizado"] as! Bool

        let mensagem = Mensagem(audio: audio, datadeEnvio: datadeEnvio, de: de, para: para, salvo: salvo, visualizado: visualizado)

        return mensagem
    }
}

//pega a id
//faz query no banco
//pega o Usuario, depois os totens do usuário e por último mensagens
