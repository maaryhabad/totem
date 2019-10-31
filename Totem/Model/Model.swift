//
//  Model.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 18/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Model {
    static let instance = Model()
    
    private init() {
        
    }
    
    let sentimento = ["cansado", "legal", "feliz", "bravo", "custom"]
    
    var usuarios : [Usuario] = [
        Usuario(imagem: "Carlos.jpg", contatos: nil, nome: "Carlos"),
        Usuario(imagem: "Alberto.jpg", contatos: nil, nome: "Alberto"),
        Usuario(imagem: "Catalina.jpg", contatos: nil, nome: "Catalina")
//        Usuario(imagem: "Catalina.jpg", contatos: nil, nome: "Catalina"),
//        Usuario(imagem: "Alberto.jpg", contatos: nil, nomeDoUsuario: "Alberto", idUsuario: 00002),
//        Usuario(imagem: "Carlos.jpg", contatos: [00001, 00002], nomeDoUsuario: "Carlos", idUsuario: 00003)
    ]
    
    
//    var totems : [Totem] = [
//        Totem(criador: usuarios[0], possuinte: usuarios[0], mensagens: nil, nome: "C2", sentimento: nil),
//        Totem(criador: usuarios[0], possuinte: usuarios[0], mensagens: nil, nome: "C3", sentimento: nil)
//    ]
//
//    var mensagens : [Mensagem] = [
//        Mensagem(audio: "audio01.m4a", datadeEnvio: "qualquer", de: usuarios[0], para: totems[0], salvo: true, visualizado: true)
//    ]
}
//salvar os usuarios
//editar a lista de contatos (no firebase, adicionar id no lugar de nil)
//criar os totens
//editar a lista de totens (no firebase, adicionar id no lugar de nil) - criador e possuinte
//criar as mensagens
